Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267404AbSLNGkG>; Sat, 14 Dec 2002 01:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbSLNGkG>; Sat, 14 Dec 2002 01:40:06 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:21001 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267404AbSLNGkF>; Sat, 14 Dec 2002 01:40:05 -0500
Date: Sat, 14 Dec 2002 14:45:57 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.5.51 ide module problem
In-Reply-To: <20021212235934.A770@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.50.0212141423230.15493-100000@boston.corp.fedex.com>
References: <200212110650.WAA13780@adam.yggdrasil.com>
 <Pine.LNX.4.50.0212111501310.30173-100000@boston.corp.fedex.com>
 <20021211004104.A362@baldur.yggdrasil.com>
 <Pine.LNX.4.50.0212111711180.4632-200000@boston.corp.fedex.com>
 <20021212235934.A770@baldur.yggdrasil.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/14/2002
 02:47:53 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/14/2002
 02:47:55 PM,
	Serialize complete at 12/14/2002 02:47:55 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Dec 2002, Adam J. Richter wrote:

> something else?).  For what it's worth, 2.5.51 + init-module-tools-0.9.3
> is the first kernel-based module loader configuration which works enough
> so that I'm able to work on other things.  For the past few releases, I
> had been restoring user level module loading.  There still are a lot of
> quirks with the kernel based module loading, but you might find it
> sufficient to get things done.

I just test your patch and IDE modules are working now on 2.5.51.
reiserfs, devmap and lvm2 are all working ... but the modules has
to be loaded in a certain order, otherwise the whole system would crash.


modprobe ide-mod
ide_info /dev/hda
--> this crashs the system
ide_mod looks for ide_hwifs, start_request, ide_do_request,
ide_do_drive_cmd, ide_diag_taskfile, ide_raw_taskfile,
taskfile_lib_get_identify, task_in_intr, proc_ide_read_identify,
proc_file_read, vfs_read, sys_read, syscall_call

modprobe ide-disk
ide_info /dev/hda
--> this works (ide-disk will load ide-mod first)

Under 2.4, I don't have to load the ide module first, calling fdisk
/dev/hda will automatically loads the ide modules, but under 2.5, I've to
manually load the ide modules.


Thanks,
Jeff.
