Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWJLLED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWJLLED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWJLLED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:04:03 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:5782 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750818AbWJLLEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:04:01 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17710.8478.278820.595718@gargle.gargle.HOWL>
Date: Thu, 12 Oct 2006 15:03:58 +0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] use %p for pointers
Newsgroups: gmane.linux.kernel
In-Reply-To: <452D3BB6.8040200@zytor.com>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
	<Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
	<20061011145441.GB29920@ftp.linux.org.uk>
	<452D3BB6.8040200@zytor.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000072 cc7871d2f332d41a766d7d3a7cf2236d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Al Viro wrote:
 > > 
 > > %p will do no such thing in the kernel.  As for the difference...  %x
 > > might happen to work on some architectures (where sizeof(void *)==sizeof(int)),
 > > but it's not portable _and_ not right.  %p is proper C for that...
 > 
 > It's really too bad gcc bitches about %#p, because that's arguably The 
 > Right Thing.

Hm...

man 3 printf:

       p      The void * pointer argument is printed in hexadeci-
              mal (as if by %#x or %#lx).

so %p already has to output '0x', it's lib/vsprintf.c to blame for
non-conforming behavior. What about

Signed-off-by: Nikita Danilov <danilov@gmail.com>

Index: git-linux/lib/vsprintf.c
===================================================================
--- git-linux.orig/lib/vsprintf.c
+++ git-linux/lib/vsprintf.c
@@ -408,7 +408,7 @@ int vsnprintf(char *buf, size_t size, co
 				}
 				str = number(str, end,
 						(unsigned long) va_arg(args, void *),
-						16, field_width, precision, flags);
+						16, field_width, precision, flags|SPECIAL);
 				continue;
 
 

