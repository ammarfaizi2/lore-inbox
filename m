Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUL2SCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUL2SCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 13:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUL2SCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 13:02:08 -0500
Received: from frigate.technologeek.org ([62.4.21.148]:38539 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S261384AbUL2SCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 13:02:03 -0500
To: Gildas LE NADAN <gildas.le-nadan@inha.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k
 2.6.10)
References: <41D14251.4030704@inha.fr>
From: Julien BLACHE <jb@jblache.org>
Date: Wed, 29 Dec 2004 19:01:43 +0100
In-Reply-To: <41D14251.4030704@inha.fr> (Gildas LE NADAN's message of "Tue,
 28 Dec 2004 12:24:01 +0100")
Message-ID: <874qi53rw8.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gildas LE NADAN <gildas.le-nadan@inha.fr> wrote:

> I experience hangs on samba processes on a filer using xfs over lvm2
> as data partitions, when there is active snapshots of the xfs
> partitions.

Your problem probably lies between lvm2 and XFS. I got the same
problems this summer while doing the exact same thing.

The server would just completely hang once I started doing lvm
snapshots:
 -> at the beginning, the snapshots would work OK, but XFS would hang
    when accessing the filesystem afterwards
 -> after a while (usually 2 or 3 snapshots, and I was taking a
    snapshot every 2 hours), the snapshot would not complete, and
    then only a hard reboot would work

I was doing the snapshots from a crontab, the script used xfs_freeze
to freeze the filesystem before doing the snapshot (and unfreeze it
afterwards, of course). Sometimes xfs_freeze -u would hang too (but at
this time, the server was in a pretty bad state already).

The server wasn't loaded at all, we were doing some reads/writes
through samba to have some modified files lying around, but we were
mainly prototyping the server, not stress-testing it.

LVM and XFS just don't play nice together when it comes to snapshots,
I thought it had been fixed already, but it's not the case, as we both
know...

(I can't remember the kernel version, it could have been a 2.4 kernel,
but I was using LVM2 and the latest XFS code available)

Feel free to correct me if I did something wrong (but AFAIK I took
care of everything, knowing there could have been bad interactions
between LVM and XFS).

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
