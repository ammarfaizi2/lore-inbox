Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSH0Gfp>; Tue, 27 Aug 2002 02:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSH0Gfp>; Tue, 27 Aug 2002 02:35:45 -0400
Received: from pop.gmx.net ([213.165.64.20]:65297 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314680AbSH0Gfn>;
	Tue, 27 Aug 2002 02:35:43 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: USB keyboards (patch)
Date: Tue, 27 Aug 2002 08:39:54 +0200
User-Agent: KMail/1.4.6
References: <200208270100.09037.nahshon@actcom.co.il> <200208270750.49576.felix.seeger@gmx.de> <200208270933.11684.nahshon@actcom.co.il>
In-Reply-To: <200208270933.11684.nahshon@actcom.co.il>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208270839.54800.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Some I time ago I sended the oops or ayiii (what is the difference, it was an 
ayiiii)

The list told me that I should use ksysmoops.

The problem doesn't come up if I plug the mouse in the usb hub of the 
keyboard.
Everything works well if it is in the first port, only the second makes the 
problem.

I hope I can reproduce it later today and run ksysmoops to get some 
information.

thanks
have fun
Felix


Am Dienstag, 27. August 2002 08:33 schrieb Itai Nahshon:
> I doubt it can fix any panic. The symptoms that I had,
> addressed by the patch, are just the keyboard not sending
> any input event.
> Is there an Oops/stack trace/other diagnostic data for
> the problem that you describe with MS Usb keyboard?
>
> -- Itai
>
> On Tuesday 27 August 2002 08:50 am, Felix Seeger wrote:
> > Does this Patch solves the kernel panic on startup with USB Mouse plugged
> > in the second usb part and MS Usb keyboard plugged in the first port ?
> >
> > thanks
> > have fun
> > Felix
> >
> > Am Dienstag, 27. August 2002 00:00 schrieb Itai Nahshon:
> > > Vojtech, Would you accept this for the 2.4 kernels?
> > >
> > > The attached patch is required to use some (buggy?)
> > > USB keyboards. IMHO it should not cause new problems
> > > with other HID devices (though, testing with hardware that
> > > I do not have is a good idea).
> > >
> > > I'm using it with recent 2.4 kernels for some time now.
> > >
> > > Just removing the call to usb_set_idle also works (but
> > > it is less efficient).
> > >
> > > The 2.5 kernels do not need this changes - they already call
> > > the equivalent of usb_set_idle (only for input reports) after
> > > reading the first report.
> > >
> > > -- Itai
> > >
> > > --- linux/drivers/usb/hid-core.c.orig	Sun Jul 21 01:19:32 2002
> > > +++ linux/drivers/usb/hid-core.c	Sun Jul 21 02:19:31 2002
> > > @@ -1065,8 +1065,8 @@
> > >  			list = report_enum->report_list.next;
> > >  			while (list != &report_enum->report_list) {
> > >  				report = (struct hid_report *) list;
> > > -				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
> > >  				hid_read_report(hid, report);
> > > +				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
> > >  				list = list->next;
> > >  			}
> > >  		}
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9ax66S0DOrvdnsewRAoYLAJ9qUQVWIuOCo0e8wlXeLMzwaDIrJQCaA7AV
WBIuKNh2odPuZkUKyz6nZrQ=
=dqd5
-----END PGP SIGNATURE-----

