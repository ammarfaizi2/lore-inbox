Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313713AbSDZIgQ>; Fri, 26 Apr 2002 04:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313714AbSDZIgP>; Fri, 26 Apr 2002 04:36:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34322 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313713AbSDZIgP>; Fri, 26 Apr 2002 04:36:15 -0400
Message-ID: <3CC902D8.4070604@evision-ventures.com>
Date: Fri, 26 Apr 2002 09:33:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.10 UTS_VERSION
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010504050302060602020805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504050302060602020805
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Make sure UTS_VERSION is allways in "C" locale.
Without it you will get (please note the day of week):

~# export LANG=en_US
~# uname -a
Linux rosomak.prv 2.5.10 #1 pi± kwi 26 09:31:52 CEST 2002 i686 unknown
~#




--------------010504050302060602020805
Content-Type: text/plain;
 name="trivial-2.5.10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trivial-2.5.10.diff"

diff -urN linux-2.5.10/Makefile linux/Makefile
--- linux-2.5.10/Makefile	2002-04-24 12:01:52.000000000 +0200
+++ linux/Makefile	2002-04-26 02:06:38.000000000 +0200
@@ -312,8 +312,8 @@
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
 	@if [ -n "$(CONFIG_SMP)" ] ; then echo -n " SMP" >> .ver; fi
 	@if [ -f .name ]; then  echo -n \-`cat .name` >> .ver; fi
-	@echo ' '`date`'"' >> .ver
-	@echo \#define LINUX_COMPILE_TIME \"`date +%T`\" >> .ver
+	@echo ' '`LANG=C date`'"' >> .ver
+	@echo \#define LINUX_COMPILE_TIME \"`LANG=C date +%T`\" >> .ver
 	@echo \#define LINUX_COMPILE_BY \"`whoami`\" >> .ver
 	@echo \#define LINUX_COMPILE_HOST \"`hostname`\" >> .ver
 	@if [ -x /bin/dnsdomainname ]; then \

--------------010504050302060602020805--

