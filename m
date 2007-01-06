Return-Path: <linux-kernel-owner+w=401wt.eu-S1751429AbXAFQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAFQh1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXAFQh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:37:27 -0500
Received: from brick.kernel.dk ([62.242.22.158]:22496 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbXAFQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:37:26 -0500
Date: Sat, 6 Jan 2007 17:37:50 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: 2.6.20-rc3-mm1: umount reiser4 FS stuck in D state
Message-ID: <20070106163750.GK11203@kernel.dk>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <459F80E2.7080903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459F80E2.7080903@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06 2007, Laurent Riffard wrote:
> Le 05.01.2007 07:02, Andrew Morton a écrit :
> >Temporarily at
> >
> >	http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1/
> >
> >will appear later at
> >
> >	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
> Hello,
> 
> got this with 2.6.20-rc3-mm1:
> 
> =======================
> SysRq : Show Blocked State
> 
>                         free                        sibling
>  task             PC    stack   pid father child younger older
> umount        D C013135E  6044  1168   1150                     (NOTLB)
>       de591ae4 00000086 de591abc c013135e dff979c8 c012a6fe 00000046 
>       00000007 dfd94ac0 128d3000 00000026 00000000 dfd94bcc dff979c8 
>       de591ae4 dffda038 00000002 dff979c0 dff979bc dff979c8 de591b10 
>       c012d600 dff979f8 00000000 Call Trace:
> [<c012d600>] synchronize_qrcu+0x70/0x8c
> [<c01bede4>] __make_request+0x4c/0x29b
> [<c01bd24b>] generic_make_request+0x1b0/0x1de
> [<c01bf354>] submit_bio+0xda/0xe2

That's certainly a barrier related hang. Since raid and XFS both hang as
well, it might be the same problem. I'll get it fixed up, don't expect
anything before monday though.

-- 
Jens Axboe

