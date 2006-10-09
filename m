Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWJIUKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWJIUKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWJIUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:10:17 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:14746 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964797AbWJIUKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:10:15 -0400
Date: Mon, 9 Oct 2006 22:08:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Helge Deller <deller@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [kernel/ subdirectory] constifications
In-Reply-To: <1160418154.3000.244.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0610092206400.23379@yvahk01.tjqt.qr>
References: <200610082121.49925.deller@gmx.de>  <1160377169.3000.189.camel@laptopd505.fenrus.org>
  <200610092016.18362.deller@gmx.de> <1160418154.3000.244.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-7550219-1160424510=:23379"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-7550219-1160424510=:23379
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> > > - completely constify string arrays,  thus move them to the rodata section
>> > 
>> > note that gcc 4.1 and later will do this automatically for static things
>> > at least...
>> 
>> Are you sure ?
>> 
>> At least with gcc-4.1.0 from SUSE 10.1 the strings array _pointers_ are not moved into the rodata section without the second "const":
>> const static char * const x[] = { "value1", "value2" };
>
>hmm I could have sworn GCC does this automatic nowadays as long as it
>can prove you're not writing to the thing (eg static and not passing the
>pointer to some external function).....

Arjan seems right:
22:07 ichi:/dev/shm > cat test.c
#include <stdio.h>
static const char *x[] = {"0", "1", NULL};
int main(void) {
    int i;
    for(i = 0; i < 3; ++i)
        printf("%s\n", x[i]);
    return 0;
}
22:07 ichi:/dev/shm > cc test.c -c && nm test.o | grep x
00000000 d x
22:07 ichi:/dev/shm > cc test.c -c -O2 && nm test.o | grep x
00000000 r x

>(even if gcc does this perfect I'm still in favor of the explicit const,
>just to catch stupid code with a warning)

Me² (read: ack)



	-`J'
-- 
--1283855629-7550219-1160424510=:23379--
