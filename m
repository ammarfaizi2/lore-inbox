Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTHDOeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271413AbTHDOeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:34:09 -0400
Received: from iv.ro ([194.105.28.94]:1970 "HELO iv.ro") by vger.kernel.org
	with SMTP id S271388AbTHDOeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:34:08 -0400
Date: Mon, 4 Aug 2003 17:48:28 +0300
From: Jani Monoses <jani@iv.ro>
To: linux-kernel@vger.kernel.org
Subject: ide-cs stack_dump
Message-Id: <20030804174828.08dfc5f4.jani@iv.ro>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
as reported by someone earlier this year there's a long stack_dump
starting from kobject_register failed with -17 (EEXISTS) when ide-cs
detects a CF card.
The reason is as I see it that both rescan_partitions and register_disk
are called, both of which in turn call add_partition for all partitions
on the CF card. add_partition calls kobject_register. Also devfs_mk_bdev
is called twice but it only prints an error msg 'could not append...'. I
don't know if that is how things should be called or whether kobjects
for IDE are broken as Alan responded to that earlier post but apart from
this initial stack_dump the card works fine (not eject of course) So is
kobject_register to verbose or calling code should make sure it does not
attempt to register the same object multiple times?

2.6.0-test2

