Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUAMOXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUAMOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 09:23:52 -0500
Received: from [211.167.76.68] ([211.167.76.68]:34199 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S264326AbUAMOXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 09:23:50 -0500
Date: Tue, 13 Jan 2004 22:21:17 +0800
From: Hugang <hugang@soulinfo.com>
To: Bart Samwel <bart@samwel.tk>
Cc: Jens Axboe <axboe@suse.de>, Jan De Luyck <lkml@kcore.org>,
       Kiko Piris <kernel@pirispons.net>, linux-kernel@vger.kernel.org,
       Dax Kelson <dax@gurulabs.com>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-Id: <20040113222117.21d1ac0b@localhost>
In-Reply-To: <4003E8BE.3000402@samwel.tk>
References: <3FFFD61C.7070706@samwel.tk>
	<200401121409.44187.lkml@kcore.org>
	<20040112140238.GG24638@suse.de>
	<200401131200.16025.lkml@kcore.org>
	<20040113110110.GA6711@suse.de>
	<4003E8BE.3000402@samwel.tk>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 13:46:54 +0100
Bart Samwel <bart@samwel.tk> wrote:

> The reiserfs patch for "commit=" was included in Linux 2.6.1. I really 
> don't know if it works with laptop mode, haven't tested it -- I don't 
> use reiserfs. So, let's ask the world: is there anyone out there who is 
> running laptop mode *successfully* with reiserfs?
Yes, I'm use reiserfs in 2.6.1 with laptop_mode patch. It works fine for me, I use cpudyn daemon to let spin download harddisk. In cpudyn.conf
I changed TIMEOUT from 120 to 10. When i reading email/web, the harddisk can spin down for very long time (>3min). 

So you can try cpudynd.

# TIMEOUT=120
TIMEOUT=10

# 
# Specified disks to spindown (comma separated devices)
#

# DISKS=/dev/hda,/dev/hdb
DISKS=/dev/hda

For now, I switch to 2.6.1-mm2, it looks fine, not need any patch.

$mount
/dev/hda13 on / type ext3 (rw,noatime,errors=remount-ro,commit=600)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/vg00/opt on /opt type reiserfs (rw,noatime,commit=600)
/dev/vg00/hugang on /home/hugang type reiserfs (rw,noatime,commit=600)
/dev/vg00/scm on /scm type reiserfs (rw,noatime,commit=600)
/dev/vg00/build on /build type reiserfs (rw,noatime,commit=600)
none on /sys type sysfs (rw)

-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
