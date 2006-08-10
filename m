Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWHJWgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWHJWgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHJWgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:36:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62359 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750782AbWHJWgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:36:10 -0400
Date: Fri, 11 Aug 2006 08:35:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Avuton Olrich <avuton@gmail.com>, "Tony.Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060811083546.B2596458@wobbly.melbourne.sgi.com>
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com> <44D55CE8.3090202@idccenter.cn> <44D56A97.2070603@idccenter.cn> <20060807143416.A2501392@wobbly.melbourne.sgi.com> <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <20060808134438.E2526901@wobbly.melbourne.sgi.com> <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com> <20060808185405.B2528231@wobbly.melbourne.sgi.com> <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>; from jesper.juhl@gmail.com on Thu, Aug 10, 2006 at 01:31:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 01:31:35PM +0200, Jesper Juhl wrote:
> On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> ...
> Ok, I booted the server with 2.6.18-rc4 + your patch. Things went well
> for ~3 hours and then blew up - not in the same way though.
> 
> The machine was under pretty heavy load recieving data via rsync when
> the following happened :
> 
> Filesystem "dm-51": XFS internal error xfs_trans_cancel at line 1138
> of file fs/xfs/xfs_trans.c.  Caller 0xc0210e3f
>  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
>  [<c0103a5e>] show_trace+0xf/0x13
>  [<c0103b59>] dump_stack+0x15/0x19
>  [<c0213474>] xfs_trans_cancel+0xcf/0xf8
>  [<c0210e3f>] xfs_rename+0x64d/0x936
>  [<c0226286>] xfs_vn_rename+0x48/0x9f
>  [<c016584e>] vfs_rename_other+0x99/0xcb
>  [<c0165a36>] vfs_rename+0x1b6/0x1eb
>  [<c0165bda>] do_rename+0x16f/0x193
>  [<c0165c45>] sys_renameat+0x47/0x73

Thanks Jesper.  Hmm, lessee - this is a cancelled dirty rename
transaction ... could be ondisk dir2 corruption (any chance this
filesystem was affected by 2.6.17's endian bug?), or something
else entirely.  No I/O errors in the system log earlier or anything
like that?

> I was doing an lvmextend +xfs_resize of a different (XFS) filesystem
> on the same server at roughly the same time. But I'm not sure if
> that's related.

That wont be related, no.

> I'm currently running xfs_repair on the fs that blew up.

OK, I'd be interested to see if that reported any directory (or
other) issues.

cheers.

-- 
Nathan
