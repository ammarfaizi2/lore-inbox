Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUGDGHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUGDGHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUGDGHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:07:25 -0400
Received: from ruth.realtime.net ([205.238.132.69]:18952 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S265396AbUGDGHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:07:15 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69CB182A-CD80-11D8-9463-003065DC03B0@bga.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: Init single and Serial console : How to ?
Date: Sun, 4 Jul 2004 01:07:22 -0500
To: Paul Rolland <rol@as2917.net>
X-Mailer: Apple Mail (2.618)
X-Server: High Performance Mail Server - http://surgemail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Configuration is quite simple : at the LILO prompt, I key in :
> LILO: linux console=ttyS0 -s
...
> The problem is that the bash prompt ends on the monitor, not on the 
> serial
> port.
...
> When you have a remote machine, for which you have a serial access at 
> boot
> time, but which is not completed its "go to runlevel 3" boot to give 
> you
> a serial console, how is it possible to force it to give you a prompt 
> on
> the serial port in single mode ?

Not quite single mode, but what I have done in similar situations is 
boot with
console=ttyS0 init=/bin/sh

which will give a shell on /dev/console before any init scripts have 
run.  At
this point mount -o remount,rw / and edit the inittab (you might need 
to mount
/usr depending on your configuration).   To get back, unmount the 
filesystems,
remount root read-only, and either reboot or (from the first shell)
exec /sbin/init -s to follow the normal bootup to single mode (Be sure 
you
remounted root ro in this case or your init scripts will likely fail).

