Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSDUAE7>; Sat, 20 Apr 2002 20:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313366AbSDUAE6>; Sat, 20 Apr 2002 20:04:58 -0400
Received: from relay1.pair.com ([209.68.1.20]:36615 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313358AbSDUAE5>;
	Sat, 20 Apr 2002 20:04:57 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC20271.A00B05BC@kegel.com>
Date: Sat, 20 Apr 2002 17:06:09 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Saving RAM on an all-RAM system by compressing executables?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with an all-RAM system (where a host processor pokes 
the linux kernel and initial ramdisk into RAM, then releases the 
reset line).  The kernel is 2.4.17 or so.
I have only 64 MB (or 32 or 16, depending), so every megabyte is precious.
The C++ app I'm running on this system is 5MB, kinda fat.
I'd like to save a couple megabytes somehow, either by compressing
the executable, or by using execute-in-place.

I made a cramfs image of the app; that shrunk it from 5MB down to 2MB.
You can't mount cramfs images from tmpfs, so I made a little ramfs, 
and loopback mounted it from there, then measured ram usage on a 64MB system
with the app both running and not running.

/bin/free reported (kb):
in tmpfs, not running: 47888
in tmpfs, running:     47244
in cramfs, not running:46972
in cramfs, running:    46336

Looks like I lose!  Using cramfs to compress the app appears to
*waste* a megabyte over just using the noncompressed app.

>From what I can tell, there's no support for execute-in-place
except on MIPS with a hacked gcc.

OK, I've exhausted my stock of clever ideas; does anyone have
a suggestion about how to save RAM in my situation?
(gzexe won't do it, nor will upx, as they all create a temporary
uncompressed file on execution...)

Thanks,
Dan
