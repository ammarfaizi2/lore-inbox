Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTE1ILq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264611AbTE1ILq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:11:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:31514 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264608AbTE1ILp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:11:45 -0400
Date: Wed, 28 May 2003 01:25:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] ext3 error: rec_len %% 4 != 0
Message-Id: <20030528012512.5d631827.akpm@digeo.com>
In-Reply-To: <8765nva43w.fsf@deneb.enyo.de>
References: <8765nva43w.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 08:25:00.0431 (UTC) FILETIME=[A15B59F0:01C324F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
>
> Sometimes, our 2.5 test machine (actually, it's a production machine,
> please don't ask why we can't use 2.4 *sigh*) stops with an ext3 error
> message.  We have now activated proper logging, and that's what we
> got:
> 
> May 28 03:23:00 kernel: EXT3-fs error (device md0): ext3_readdir: bad entry in directory #16056745: rec_len %% 4 != 0 - offset=52, inode=431743, rec_len=37017, name_len=41 

Are you using htree?  Run

	dumpe2fs -h /dev/hda1 | grep features

and if it says "dir_index" then try turning it off:

	tune2fs -O ^dir_index /dev/hda1

and reboot.

If it is not an htree problem (and htree seems pretty stable now) then
possibly the IO system has lost some data.  If possible, try using a normal
old disk (no RAID).

Falling back to ext2 for a while would be interesting.

