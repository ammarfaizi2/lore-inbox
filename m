Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSHEVED>; Mon, 5 Aug 2002 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSHEVEC>; Mon, 5 Aug 2002 17:04:02 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:27636 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318421AbSHEVD6>; Mon, 5 Aug 2002 17:03:58 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Tue, 6 Aug 2002 07:02:22 +1000
User-Agent: KMail/1.4.5
Cc: Tyler Longren <tyler@captainjack.com>, kiza@gmx.net,
       LKML <linux-kernel@vger.kernel.org>
References: <20020805003427.7e7fc9f4.tyler@captainjack.com> <200208060001.07546.bhards@bigpond.net.au> <20020805165601.GA27503@kroah.com>
In-Reply-To: <20020805165601.GA27503@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208060702.29360.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 6 Aug 2002 02:56, Greg KH wrote:
> On Tue, Aug 06, 2002 at 12:00:55AM +1000, Brad Hards wrote:
> > Greg: I think this was one of your patches, associated with the
> > HIDINPUT patch. It looks like the return value is wrong. See
> > below.
> >
> > --- include/linux/hiddev.h.orig Mon Aug  5 23:19:54 2002
> > +++ include/linux/hiddev.h      Mon Aug  5 23:56:34 2002
> > @@ -183,7 +183,7 @@
> >  int __init hiddev_init(void);
> >  void __exit hiddev_exit(void);
> >  #else
> > -static inline void *hiddev_connect(struct hid_device *hid) { return
> > NULL; } +static inline void *hiddev_connect(struct hid_device *hid) {
> > return -1; } static inline void hiddev_disconnect(struct hid_device *hid)
> > { } static inline void hiddev_hid_event(struct hid_device *hid, unsigned
> > int usage, int value) { } static inline int hiddev_init(void) { return 0;
> > }
>
> ??? Why return -1 as a void *?
>
> The only caller of hiddev_connect is:
> 	if (!hiddev_connect(hid))
> 		hid->claimed |= HID_CLAIMED_HIDDEV;
>
> Hm, seems like you don't want a void * there at all, but a int, right?
I assume so.

> But that doesn't explain the error people are having with the code
> compiled in.
No - while doing the investigation, I noted that dmesg was showing
input0,hiddev0: USB HID v1.10 Keyboard [045e:001d] on usb2:3.0
input1,hiddev0: USB HID v1.10 Pointer [045e:001d] on usb2:3.1
input2,hiddev0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse M-BA47] on usb2:4.0

with CONFIG_USB_HIDDEV turned off.

So I chased that down to the above conclusion.

But I still don't see the problem, and can't duplicate it.

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9TufiW6pHgIdAuOMRAojFAKCmSOjjTwcp6z7tPKeR6kaokAF71wCginFW
5/94epXIyAJlfpFGtmQqxOY=
=Ywrd
-----END PGP SIGNATURE-----

