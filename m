Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVAIQC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVAIQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVAIQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:02:56 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:50290 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261497AbVAIQCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:02:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roey Katz <roey@sdf.lonestar.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sun, 9 Jan 2005 11:02:51 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501090035.07247.dtor_core@ameritech.net> <Pine.NEB.4.61.0501091421530.22271@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501091421530.22271@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501091102.51246.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 09:24 am, Roey Katz wrote:
> I tried (at the top of 2.6.9rc2-bk3/ ), "cat 
> dmitrys-patch | patch -p1".  It complained of rejecting hunks and whatnot:
> 
> patching file drivers/Makefile
> Hunk #1 FAILED at 21.
> Hunk #2 FAILED at 43.
> 2 out of 2 hunks FAILED -- saving rejects to file drivers/Makefile.rej
> 
> I tried this in 2.6.10/, but got the same response.
>

Most likely you selected and then pasted the patch while in X. This caused
whitespace damage to the patch (tabs were converted to spaces). Try saving
the entire message into a file with your MUA and feed the result to the
"patch" command.

Alternatively, just edit drivers/Makefile and move the line mentioning
"input/serio" to be just above the line mentioning "input".
  
> > ===== drivers/Makefile 1.50 vs edited =====
> > --- 1.50/drivers/Makefile	2004-12-01 01:00:21 -05:00
> > +++ edited/drivers/Makefile	2005-01-09 00:33:32 -05:00
> > @@ -21,9 +21,6 @@
> > obj-$(CONFIG_FB_I810)           += video/i810/
> > obj-$(CONFIG_FB_INTEL)          += video/intelfb/
> >
> > -# we also need input/serio early so serio bus is initialized by the time
> > -# serial drivers start registering their serio ports
> > -obj-$(CONFIG_SERIO)		+= input/serio/
> > obj-y				+= serial/
> > obj-$(CONFIG_PARPORT)		+= parport/
> > obj-y				+= base/ block/ misc/ net/ media/
> > @@ -46,6 +43,7 @@
> > obj-$(CONFIG_TC)		+= tc/
> > obj-$(CONFIG_USB)		+= usb/
> > obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> > +obj-$(CONFIG_SERIO)		+= input/serio/
> > obj-$(CONFIG_INPUT)		+= input/
> > obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> > obj-$(CONFIG_I2O)		+= message/
> >
> 

-- 
Dmitry
