Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVFSPjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVFSPjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 11:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFSPjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 11:39:35 -0400
Received: from mail.linicks.net ([217.204.244.146]:4617 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262254AbVFSPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 11:39:29 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Sun, 19 Jun 2005 16:39:27 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506191639.27970.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Haninger wrote:

> Anyway, just a heads-up to anyone else experiencing a breaking of
> 'less' and missing /dev files.

Yep... I had 'less' break too (you will find 'man' is broke also, rolling on 
from that).

It turns out to be a problem (typo?) in  /etc/udev/rules.d/udev.rules

Try changing:

# pty devices
KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
KERNEL="tty[p-za-e][0-9a-f]*", NAME="tty/s%n", SYMLINK="%k"

to:

# pty devices
KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
KERNEL="tty[p-za-e][0-9a-f]*", NAME="pty/s%n", SYMLINK="%k"

(change is in second line tty -> pty)

As to the missing /dev/ entries - remember you are using udev now - they 
appear 'on the fly' as and when you plug something in - ensure you have set 
'hotplug' to start.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
