Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCYT0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCYT0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWCYT0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:26:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61899 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750830AbWCYT0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:26:31 -0500
Date: Sat, 25 Mar 2006 20:26:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/16] UML - Memory hotplug
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
 <20060324144535.37b3daf7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-591466255-1143314768=:29793"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-591466255-1143314768=:29793
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


>> +	char buf[sizeof("18446744073709551615\0")];
>
>rofl.  We really ought to have a #define for "this architecture's maximum
>length of an asciified int/long/s32/s64".  Generally people do
>guess-and-giggle-plus-20%, or they just get it wrong.

And this one seems wrong[*] to me too (making it a rofl²).
It is two chars (or one[*]) too long.

Consider this test:

	#include <stdio.h>
	#include <string.h>
	int main(void) {
	    printf("%d\n", sizeof("18446744073709551615\0"));
	    printf("%d\n", sizeof("18446744073709551615"));
	    printf("%d\n", strlen("18446744073709551615"));
	}

Which will print, when executed,

	22
	21
	20	(the "pure string" length)

[*] Depending on what the original author wanted.



Jan Engelhardt
-- 
--1283855629-591466255-1143314768=:29793--
