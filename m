Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754321AbWKMPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbWKMPxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbWKMPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:53:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:41017 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754321AbWKMPxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:53:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B4kO+c5ue60TR7y5rrzQzkng/ZCSXBzwWpVYzry0H3Olkzl/wgVs0WR0ZDjslAzIC2R7OQYwXFTEv1JBVypySFo6J9FGief7345z/PO2XA4/aJ9Tasj1Jg7hHkChG9ixs2k24Vft50LsViU27nKWIhq3isx3g2w1y1qHUTcFYIs=
Message-ID: <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
Date: Mon, 13 Nov 2006 10:53:19 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Stelian Pop" <stelian@popies.net>
Subject: Re: [PATCH] Apple Motion Sensor driver
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Paul Mackerras" <paulus@samba.org>, "Robert Love" <rml@novell.com>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Rene Nussbaumer" <linux-kernel@killerfox.forkbomb.ch>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1163431758.23444.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Stelian Pop <stelian@popies.net> wrote:
> Le lundi 13 novembre 2006 à 10:04 -0500, Dmitry Torokhov a écrit :
> > Hi Stelian,
> >
> > On 11/11/06, Stelian Pop <stelian@popies.net> wrote:
> >
> >  +
> > > +       if (input_register_device(ams_info.idev)) {
> > > +               input_free_device(ams_info.idev);
> > > +               ams_info.idev = NULL;
> > > +               return;
> > > +       }
> > > +
> > > +       ams_info.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
> > > +       if (IS_ERR(ams_info.kthread)) {
> > > +               input_unregister_device(ams_info.idev);
> > > +               ams_info.idev = NULL;
> > > +               return;
> > > +       }
> > > +}
> >
> > Please consider implementing ams_mouse_start() and ams_mouse_stop()
> > methods for input_dev and start/stop polling thread there - there is
> > no reason to report input events when noone listens to them.
>
> I suppose you talk about input_dev->open() and close() ?
>

Yep.

> +
> +static int ams_mouse_open(struct input_dev *dev)
> +{
> +       ams_info.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
> +       return IS_ERR(ams_info.kthread) ? -ENODEV : 0;
> +}
> +

Is there a reason why you reporting -ENODEV instead of real error code
from kthread_run()?

-- 
Dmitry
