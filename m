Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFXXef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFXXee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:34:34 -0400
Received: from h00c0263128af.ne.client2.attbi.com ([24.60.89.166]:31244 "EHLO
	sapphire.no-ip.com") by vger.kernel.org with ESMTP id S263375AbTFXXeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:34:31 -0400
From: Rick Warner <rick@sapphire.no-ip.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 byteorder.h problem with__u64
Date: Tue, 24 Jun 2003 19:48:33 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306241948.34044.rick@sapphire.no-ip.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am in the process of building a LFS system using gcc 3.2.3, glibc 2.3.2, and 
linux 2.4.21. I have the full system built short of kde. In building the 
kdemultimedia package from kde-3.1.2, I get errors regarding __u64 being 
undefined in byteorder.h on the swab64 function.  This function is dependent 
on _GNU_ being defined, while the __u64 type is only defined when _GNU_ is 
defined and _STRICT_ANSI_ is not.

I found some references to this from 5/6/03 timeframe for 2.4.21-rc1 with a 
patch included, but this patch was not included into 2.4.21!  The error is 
still there!  The messages in the thread were just arguments about userland 
progs including kernel headers.... if userland isn't supposed to use kernel 
headers.. why are they copied into /usr/include !?  It is perfectly normal 
for a userland app to include cdrom.h.. which in turn includes the 
problematic file......

I have used the patch which removes the swab64 function when _STRICT_ANSI_ is 
defined on my byteorder.h... this has resolved my problem....

My real question is why this hasn't been included in the 2.4.21 release.  
Having a type be used with _STRICT_ANSI_ defined when the type isn't defined 
when _STRICT_ANSI_ is defined is definately wrong.  It can't stay the way it 
is.  If people want to argue about the "correct" solution (either defining 
__u64 regardless of _STRICT_ANSI_ or not defining the swab64 function if 
_STRICT_ANSI_ is defined), that's fine... as long as SOME solution is put in 
place.
