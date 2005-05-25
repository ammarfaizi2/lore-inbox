Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVEYRo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVEYRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVEYRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:44:26 -0400
Received: from animx.eu.org ([216.98.75.249]:52389 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261512AbVEYRoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:44:22 -0400
Date: Wed, 25 May 2005 13:41:35 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: initramfs
Message-ID: <20050525174135.GA1098@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with this.  I apparently have a cpio archive that the
kernel likes.  I am starting via grub with basically:
kernel /mykernel
initrd /mycpiofile

At first, I got "can't mount root".  A little reading in main.c has it
looking for /init  (shouldn't this be /bin/init instead?)

I moved my ./bin/init to . in my init filesystem tree and recreated the
cpio.  my ./init script is a "#!/bin/busybox ash" script.

running cpio -tv, I see:
...
-rwxr-xr-x   1 root     root       452508 May  5 14:33 bin/busybox
...
-rwxr-xr-x   1 root     root         1328 May  9 15:46 init
...

Now I see a message saying:
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

I did that.  According to the source, init= is overridden when /init exists.

I'd like to get off the initrd ramdisk style to save some more on space.

I assume it is populating properly since also I don't see the initial console
warning message.

Kernel: vanilla 2.6.12-rc4 compiled with -Os with debian gcc 3.3.5-1

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
