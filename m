Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWEOMuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWEOMuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWEOMuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:50:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13120 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750766AbWEOMuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:50:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P1ecMjEGWeAuhJUflpW3QhvOdYH9JcgwHw01lSVHXx97jklZVBdQEi+3Lf/b/itYiYyUvYm57bhqEhBzuJqh6vcVaYyhdZ6i1wIPmdjfYjmZ5Jh5N5KSRQHBANDc5yMPatEHuVGbs8JB0aqpQsh2bJKCG4cDerXKe7oYSO8oRmc=
Message-ID: <70066d530605150550q55deb127w1ab2a4451b065a54@mail.gmail.com>
Date: Mon, 15 May 2006 08:50:50 -0400
From: "Jaya Kumar" <jayakumar.video@gmail.com>
To: "Oliver Neukum" <oliver@neukum.name>
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605151235.10690.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605150849.k4F8nXDb031881@localhost.localdomain>
	 <200605151235.10690.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Oliver Neukum <oliver@neukum.name> wrote:
> Am Montag, 15. Mai 2006 10:49 schrieb jayakumar.video@gmail.com:
> > +urb->status = 0;
> > +urb->actual_length = 0;
>
> These are not needed. Indeed you should never write to those fields.
>
>         Regards
>                 Oliver
>

I see. Good point. I ought to have actually looked at usb_submit_urb
and seen that it initializes status and actual_length. I'll make the
change.

To reduce my embarrassment, I'll point out that several other media
drivers also do this:

drivers/usb/media % egrep "urb->status.*=" *.c
<snip>
konicawc.c:        urb->status = 0;
se401.c:        urb->status=0;
stv680.c:       urb->status = 0;
usbvideo.c:     urb->status = 0;
w9968cf.c:      urb->status = 0;

In most of the above cases, it appears to be just before resubmitting the urb.

Thanks,
jaya
