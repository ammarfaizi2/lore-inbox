Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVC1HeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVC1HeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVC1HeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 02:34:17 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:23219 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S261214AbVC1HeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 02:34:08 -0500
Date: Mon, 28 Mar 2005 10:34:05 +0300
From: Ville Herva <vherva@vianova.fi>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3
Message-ID: <20050328073405.GQ16169@viasys.com>
Reply-To: vherva@viasys.com
References: <20050326162801.GA20729@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326162801.GA20729@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 01:28:01PM -0300, you [Marcelo Tosatti] wrote:
> 
> Hi, 
> 
> Here goes -rc3.
> 
> A nasty typo happened while merging v2.6 load_elf_library() DoS fix,
> which could leap to oopses.
> 
> Summary of changes from v2.4.30-rc2 to v2.4.30-rc3
> ============================================
> 
> Marcelo Tosatti:
>   o Andreas Arens: Fix deadly mismerge of binfmt_elf DoS fix
>   o Change VERSION to 2.4.30-rc3

I just upgraded from linux-2.4.21 + vserser 0.17 to 2.4.30rc3 + vserver
1.2.10. The box has been running stable with 2.4.21 + vserver 0.17/0.16 for
a few years (uptime before reboot was nearly 400 days.)

The boot went fine, but after few hours I got 
Message from syslogd@box at Sun Mar 27 22:07:00 2005 ...
turing kernel: journal commit I/O error

and dmesg is filled with 
--8<-----------------------------------------------------------------------
EXT3-fs error (device md(9,3)) in start_transaction: Journal has aborted
EXT3-fs error (device md(9,3)) in start_transaction: Journal has aborted
EXT3-fs error (device md(9,3)) in start_transaction: Journal has aborted
EXT3-fs error (device md(9,3)) in start_transaction: Journal has aborted
--8<-----------------------------------------------------------------------

This is roofs, on top software raid1 and two ide disks. mdstat claims it's
healthy:

--8<-----------------------------------------------------------------------
md3 : active raid1 hdc3[1] hda3[0]
      37955648 blocks [2/2] [UU]
--8<-----------------------------------------------------------------------

While dmesg has filled up and /var/log/messages is read-only - I can't see
all the kernel messages - there appears to be no IO errors from the
underlying devices (md, ide). smartctl -a does not report errors for hda nor
hdc.

During reboot, fsck was run for md3, and it was clean. Now I get

--8<-----------------------------------------------------------------------
Block bitmap differences:  -(7800660--7801060) -(7801934--7802030) -(7802370--7802602) -(7802604--7802613) -(7802681--7802700) -(7802715--7802716) -(7802726--7802732) -(7802744--7802750)-(7802914--7802927) -(7802934--7802937) -(7802946--7802964)  -(7803392--7803417) -(7805060--7808825) -(7808976--7809608) 
Fix? no

Inode bitmap differences:  -3899400
Fix? no
--8<-----------------------------------------------------------------------

No errors from the badblocks part of the fsck, though.

Running fsck triggers the "journal commit I/O error" messages again, and
still no IO errors from either md or ide.

This _could_ have something to do with the vserver patch but it doesn't
appear so. Also, it doesn't immediately look like hardware problem. 

Any ideas?


-- v -- 

v@iki.fi

