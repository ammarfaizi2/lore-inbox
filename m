Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUIVVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUIVVao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUIVVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:30:43 -0400
Received: from gprs214-200.eurotel.cz ([160.218.214.200]:20361 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267401AbUIVVal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:30:41 -0400
Date: Wed, 22 Sep 2004 23:30:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: year 9223372034708485227 problem
Message-ID: <20040922213028.GE14891@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For testing (read() and write() is returning wrong value on 2.4
kernels) I played a bit with really big numbers... And I found out we
have year 9223372034708485227 problem ;-).

hobit:/tmp # cat 2gbtime.c

/**************************** 2gbwrite.c **************************/
#define _SVID_SOURCE /* glibc2 needs this */
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <values.h>
#include <malloc.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

int main(int argc, char **argv)
{
  long t = 0x7fffffff80123456;
  stime(&t);
  printf("It is now: %lx\n", time(NULL));
}
/*********************** end of 2gbwrite.c *************************/
hobit:/tmp # ./2gbtime
It is now: 7fffffff80123456
hobit:/tmp # date
Segmentation fault
hobit:/tmp # top
Segmentation fault
hobit:/tmp # mc
Segmentation fault
hobit:/tmp # /sbin//shutdown -r now
Segmentation fault
hobit:/tmp # halt
Segmentation fault
hobit:/tmp #

I'm not sure if it is kernel problem... but it is sure pretty
common. I wonder how much damage it will do to my filesystems: touch
foo seems to store the right year into reiserfs. I wonder if it is
still there after reboot? No, it is not. That looks like kernel bug :-).

Anyway I believe we are going to have some fun in year 2038. Even if
all systems are 64-bit by then, there will still be some 32-bit fields
hidden somewhere.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
