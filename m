Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130096AbRBZBSR>; Sun, 25 Feb 2001 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130099AbRBZBSI>; Sun, 25 Feb 2001 20:18:08 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:40206 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130096AbRBZBR5>; Sun, 25 Feb 2001 20:17:57 -0500
Message-ID: <3A99AE92.E9D2D0E8@eikon.tum.de>
Date: Mon, 26 Feb 2001 02:17:06 +0100
From: Mario Hermann <ario@eikon.tum.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Oppenheim <jono@Phys.UAlberta.CA>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 242-ac3 loop bug
In-Reply-To: <Pine.LNX.4.10.10102251701520.2320-100000@dirac.phys.ualberta.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Jonathan Oppenheim wrote:

> i have also been having trouble with many cyphers including
> blowfish (although twofish and idea worked).  the error seems to be the
> same in all 2.4.x kernels (i have all the relevant options compiled
> as modules eg. loopback and ciphers))

I had the same problem today with blowfish. Following mini-diff works for
blowfish(apply after patch-int-2.4.0.3):

--- crypto/cipher-blowfish.c~   Sun Feb 25 13:33:42 2001
+++ crypto/cipher-blowfish.c    Sun Feb 25 13:48:23 2001
@@ -404,6 +404,8 @@
     u32 *P = key2->P;
     u32 *S = key2->S;

+    if (keybytes<=0 || keybytes>32) return(-1);
+
     /* Copy the initialization s-boxes */

     for (i = 0, count = 0; i < 256; i++)





