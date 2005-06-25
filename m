Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFYLKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFYLKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 07:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbVFYLKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 07:10:45 -0400
Received: from mail.linicks.net ([217.204.244.146]:14346 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261174AbVFYLKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 07:10:40 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: IDE probing IDE_MAX_HWIFS
Date: Sat, 25 Jun 2005 12:10:37 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251210.37623.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I am investigating the IDE probing at boot (i386), and wanted to find an easy 
way to pass the 'noprobe' command line to all the (non-existant) IDE 
interfaces at once(ish) rather than having 'ide2=noprobe ide3=noprobe 
ide4=noprobe...'

Now I have traced the code, I see that HWIFS is 6 or 10
include/asm-i386/ide.h:

#ifndef MAX_HWIFS
# ifdef CONFIG_BLK_DEV_IDEPCI
#define MAX_HWIFS       10
# else
#define MAX_HWIFS       6
# endif
#endif

Looking at the Kconfig, I see APLHA & SUPERH do get an option to change this 
to suit
drivers/ide/Kconfig

config IDE_MAX_HWIFS
        int "Max IDE interfaces"
        depends on ALPHA || SUPERH
        default 4
        help
          This is the maximum number of IDE hardware interfaces that will
          be supported by the driver. Make sure it is at least as high as
          the number of IDE interfaces in your system.

Now my question :-)  Is there a specific reason why this isn't included in 
other architectures?  I am asking as I guess one hell of a lot of people 
running on i386 have only two IDE interfaces anyway, and it could do with 
defining it as 2...

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
