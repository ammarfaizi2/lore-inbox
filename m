Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753872AbWKFWS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbWKFWS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbWKFWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:18:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:38010 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753872AbWKFWSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:18:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oNjWlQVbeVmsyqhcYqxV/mlTkuMs0QWQLsBqxnFw7GBP/vO1gkE/LBjCu9s/4SpGaLP7DSMoeUruRRCqtV9gGO8SzK52KT+D1zeNjhziOg4LM+ar8eFKlSTnlr7ISjur1i2DRHgFtOK9vbDGeODl1xhdPyWSJvbbFU9d8QtchDM=
Message-ID: <d120d5000611061418i65f27cd6w1c60692aff8bd1b1@mail.gmail.com>
Date: Mon, 6 Nov 2006 17:18:53 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Cc: "Burman Yan" <yan_952@hotmail.com>, linux-kernel@vger.kernel.org,
       "Jean Delvare" <khali@linux-fr.org>
In-Reply-To: <20061106131535.04ffa895.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY20-F36829F468180F55694798D8FE0@phx.gbl>
	 <20061106131535.04ffa895.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 03 Nov 2006 18:33:31 +0200
> "Burman Yan" <yan_952@hotmail.com> wrote:
> > +
> > +static unsigned int mouse = 0;
>
> The `= 0' is unneeded.
>
> > +module_param(mouse, bool, S_IRUGO);
> > +MODULE_PARM_DESC(mouse, "Enable the input class device on module load");

Does the parameter have to be called "mouse"? I'd rename it to "input"
and drop the work "class" from parameter description.

> > +
> > +     if (input_register_device(mdps.idev)) {
> > +             input_free_device(mdps.idev);
> > +             mdps.idev = NULL;
> > +             return;
> > +     }
> > +
> > +     mdps.kthread = kthread_run(mdps_mouse_kthread, NULL, "kmdps");
> > +     if (IS_ERR(mdps.kthread)) {
> > +             input_unregister_device(mdps.idev);
> > +             mdps.idev = NULL;
> > +             return;
> > +     }
> > +

Please consider implementing mdps_input_open() and mdps_input_close()
and create and run the polling thread from there - there is no point
in polling the device if noone listens to its events.

-- 
Dmitry
