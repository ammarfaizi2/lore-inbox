Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGYOsa>; Thu, 25 Jul 2002 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGYOs3>; Thu, 25 Jul 2002 10:48:29 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:41434 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S315282AbSGYOs2>; Thu, 25 Jul 2002 10:48:28 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Date: Fri, 26 Jul 2002 00:47:20 +1000
User-Agent: KMail/1.4.5
References: <20020725083716.A20717@ucw.cz> <20020725161132.A22767@ucw.cz> <20020725163816.A23988@ucw.cz>
In-Reply-To: <20020725163816.A23988@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207260047.20953.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 00:38, Vojtech Pavlik wrote:
> Hi!
>
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
> work.
>
> ===================================================================
>
> ChangeSet@1.448, 2002-07-25 16:36:05+02:00, vojtech@twilight.ucw.cz
>   Add EVIOCSABS() ioctl to change the abs* informative
>   values on input devices. This is something the X peoople
>   really wanted.
Grr. I was just working on modifying this ioctl() to return
something better than int[5], which is pretty ugly.

How about something along these lines (I have the rest of it - its
just trivial changes to evdev.c)?

I could live with curr, min and max instead of *_value, but it
would be nicer if it was a bit more descriptive.

Brad



diff -Naur -X dontdiff linux-2.5.27-eventapi/include/linux/input.h linux-2.5.27-eventapi2/include/linux/input.h
--- linux-2.5.27-eventapi/include/linux/input.h Tue Jul 23 21:36:37 2002
+++ linux-2.5.27-eventapi2/include/linux/input.h        Fri Jul 26 00:17:57 2002
@@ -63,6 +63,14 @@
        uint16_t version;
 };

+struct input_absinfo {
+       int curr_value;
+       int min_value;
+       int max_value;
+       int fuzz;
+       int flat;
+};
+
 #define EVIOCGVERSION          _IOR('E', 0x01, int)                    /* get driver version */
 #define EVIOCGID               _IOR('E', 0x02, struct input_devinfo)   /* get device ID */
 #define EVIOCGREP              _IOR('E', 0x03, int[2])                 /* get repeat settings */
@@ -79,7 +87,7 @@
 #define EVIOCGSND(len)         _IOC(_IOC_READ, 'E', 0x1a, len)         /* get all sounds status */

 #define EVIOCGBIT(ev,len)      _IOC(_IOC_READ, 'E', 0x20 + ev, len)    /* get event bits */
-#define EVIOCGABS(abs)         _IOR('E', 0x40 + abs, int[5])           /* get abs value/limits */
+#define EVIOCGABS(abs)         _IOR('E', 0x40 + abs, struct input_absinfo)     /* get abs value/limits */

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
