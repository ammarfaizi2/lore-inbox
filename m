Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318469AbSHEOCe>; Mon, 5 Aug 2002 10:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHEOCe>; Mon, 5 Aug 2002 10:02:34 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:24276 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318469AbSHEOCd>; Mon, 5 Aug 2002 10:02:33 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tyler Longren <tyler@captainjack.com>, kiza@gmx.net
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Tue, 6 Aug 2002 00:00:55 +1000
User-Agent: KMail/1.4.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20020805003427.7e7fc9f4.tyler@captainjack.com> <200208052114.15020.bhards@bigpond.net.au>
In-Reply-To: <200208052114.15020.bhards@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208060001.07546.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Aug 2002 21:14, Brad Hards wrote:
> On Mon, 5 Aug 2002 15:34, Tyler Longren wrote:
> > Just to let you know, this problem isn't just happening to you.
> >
> > I compiled 2.4.19 using the same config file I used for 2.4.18 (yes, I
> > also turned on CONFIG_USB_HIDINPUT).  Needless to say, the mouse didn't
> > work on reboot.  I saw your post and compiled everything into the
> > kernel, and everything worked great on reboot.  So, I think this is
> > probably a real 2.4.19 problem.  Not something specific to you.
>
> I'm taking a look now.
I can't duplicate this problem yet.

> Could you (and anyone else with the same problem), mail me the
> lines from .config that matches CONFIG_USB for a configuration
> that fails to work. Off list would be best.
One issue that did come up was the handling of the no-HIDDEV case.

Greg: I think this was one of your patches, associated with the 
HIDINPUT patch. It looks like the return value is wrong. See 
below.

- --- include/linux/hiddev.h.orig Mon Aug  5 23:19:54 2002
+++ include/linux/hiddev.h      Mon Aug  5 23:56:34 2002
@@ -183,7 +183,7 @@
 int __init hiddev_init(void);
 void __exit hiddev_exit(void);
 #else
- -static inline void *hiddev_connect(struct hid_device *hid) { return NULL; }
+static inline void *hiddev_connect(struct hid_device *hid) { return -1; }
 static inline void hiddev_disconnect(struct hid_device *hid) { }
 static inline void hiddev_hid_event(struct hid_device *hid, unsigned int usage, int value) { }
 static inline int hiddev_init(void) { return 0; }

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ToUbW6pHgIdAuOMRAvrRAJwOdrWv4FEHyW7cwMiC+CrMM/kXrgCbBHGR
Kq110ZnHc98yN4YPJJAuCIU=
=ck4u
-----END PGP SIGNATURE-----

