Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSH0G26>; Tue, 27 Aug 2002 02:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSH0G26>; Tue, 27 Aug 2002 02:28:58 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:1418 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S314602AbSH0G25>; Tue, 27 Aug 2002 02:28:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Felix Seeger <felix.seeger@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: USB keyboards (patch)
Date: Tue, 27 Aug 2002 09:33:11 +0300
User-Agent: KMail/1.4.3
References: <200208270100.09037.nahshon@actcom.co.il> <200208270750.49576.felix.seeger@gmx.de>
In-Reply-To: <200208270750.49576.felix.seeger@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208270933.11684.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt it can fix any panic. The symptoms that I had,
addressed by the patch, are just the keyboard not sending
any input event.
Is there an Oops/stack trace/other diagnostic data for
the problem that you describe with MS Usb keyboard?

-- Itai


On Tuesday 27 August 2002 08:50 am, Felix Seeger wrote:
> Does this Patch solves the kernel panic on startup with USB Mouse plugged
> in the second usb part and MS Usb keyboard plugged in the first port ?
>
> thanks
> have fun
> Felix
>
> Am Dienstag, 27. August 2002 00:00 schrieb Itai Nahshon:
> > Vojtech, Would you accept this for the 2.4 kernels?
> >
> > The attached patch is required to use some (buggy?)
> > USB keyboards. IMHO it should not cause new problems
> > with other HID devices (though, testing with hardware that
> > I do not have is a good idea).
> >
> > I'm using it with recent 2.4 kernels for some time now.
> >
> > Just removing the call to usb_set_idle also works (but
> > it is less efficient).
> >
> > The 2.5 kernels do not need this changes - they already call
> > the equivalent of usb_set_idle (only for input reports) after
> > reading the first report.
> >
> > -- Itai
> >
> > --- linux/drivers/usb/hid-core.c.orig	Sun Jul 21 01:19:32 2002
> > +++ linux/drivers/usb/hid-core.c	Sun Jul 21 02:19:31 2002
> > @@ -1065,8 +1065,8 @@
> >  			list = report_enum->report_list.next;
> >  			while (list != &report_enum->report_list) {
> >  				report = (struct hid_report *) list;
> > -				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
> >  				hid_read_report(hid, report);
> > +				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
> >  				list = list->next;
> >  			}
> >  		}
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


