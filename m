Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313136AbSDDLVg>; Thu, 4 Apr 2002 06:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSDDLV0>; Thu, 4 Apr 2002 06:21:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54031 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313136AbSDDLVJ>; Thu, 4 Apr 2002 06:21:09 -0500
Message-ID: <3CAC28A7.1060500@evision-ventures.com>
Date: Thu, 04 Apr 2002 12:19:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
In-Reply-To: <Pine.LNX.4.33.0204031714080.12444-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By just reading the patch I have came across the following code:

diff -Nru a/arch/cris/drivers/ethernet.c b/arch/cris/drivers/ethernet.c
--- a/arch/cris/drivers/ethernet.c	Wed Apr  3 17:11:15 2002
+++ b/arch/cris/drivers/ethernet.c	Wed Apr  3 17:11:15 2002
......

@@ -1313,7 +1313,7 @@
  static void
  e100_clear_network_leds(unsigned long dummy)
  {
- 
if (led_active && jiffies > led_next_time) {
+ 
if (led_active && jiffies > time_after(jiffies, led_next_time)) {
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should almost certainly be instead:

+ 
if (led_active && time_after(jiffies, led_next_time)) {
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

