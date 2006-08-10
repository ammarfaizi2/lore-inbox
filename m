Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWHJMZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWHJMZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbWHJMZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:25:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:16591 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161211AbWHJMZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:25:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mR/GfxVksa5UjWvfflXCh2ZdnCyZiY53wxf0Qwb5kIICxxiITp4jkohzHJU6e1/ch/4mRAy6Zzn9XbJ4uypgMS1QI3T1P3I4EOwXehEnTULHBc8WskhLFS5WZvY3AnYT4pLAUYRlZRq8X+5UVv6fq0zXsv+/xAAtIXuhCkcW4o0=
Message-ID: <9a8748490608100525n787b6eafjc42b67e5e7aef00e@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:25:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: "Avuton Olrich" <avuton@gmail.com>, "Tony. Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
	 <20060804200549.A2414667@wobbly.melbourne.sgi.com>
	 <44D55CE8.3090202@idccenter.cn> <44D56A97.2070603@idccenter.cn>
	 <20060807143416.A2501392@wobbly.melbourne.sgi.com>
	 <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>
	 <20060808134438.E2526901@wobbly.melbourne.sgi.com>
	 <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>
	 <20060808185405.B2528231@wobbly.melbourne.sgi.com>
	 <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Tue, Aug 08, 2006 at 10:37:49AM +0200, Jesper Juhl wrote:
> > > On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > > On Mon, Aug 07, 2006 at 08:39:49PM -0700, Avuton Olrich wrote:
> > > > > On 8/6/06, Nathan Scott <nathans@sgi.com> wrote:
> > > > > > On Sun, Aug 06, 2006 at 12:05:43PM +0800, Tony.Ho wrote:
> > > > > > > I'm sorry about prev mail. I test on a wrong kernel.
> > > > > > > The panic is not appear again,
> > > > >
> > > > > Using 2.6.18-rc4, is this the bug that this thread refers to?
> > > >
> > > > Yes, try http://oss.sgi.com/archives/xfs/2006-08/msg00054.html
> > > > and lemme know what happens - thanks.
> > > >
> > > Come wednesday would you like me to try rc4 + that patch instead of
> > > rc3-git3 with your previous patch?
> >
> > Yep, ignore that first patch.  Thanks!
> >
>
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
>  [<c0165c98>] sys_rename+0x27/0x2b
>  [<c0102ae3>] syscall_call+0x7/0xb
>  [<b7e0a681>] 0xb7e0a681
>  [<c0213474>] xfs_trans_cancel+0xcf/0xf8
>  [<c0210e3f>] xfs_rename+0x64d/0x936
>  [<c0210e3f>] xfs_rename+0x64d/0x936
>  [<c0226286>] xfs_vn_rename+0x48/0x9f
>  [<c01626bb>] exec_permission_lite+0x46/0xcd
>  [<c0162acb>] __link_path_walk+0x4d/0xd0a
>  [<c016f8df>] mntput_no_expire+0x1b/0x78
>  [<c01637f3>] link_path_walk+0x6b/0xc4
>  [<c016584e>] vfs_rename_other+0x99/0xcb
>  [<c022623e>] xfs_vn_rename+0x0/0x9f
>  [<c0165a36>] vfs_rename+0x1b6/0x1eb
>  [<c0165bda>] do_rename+0x16f/0x193
>  [<c0154e6b>] sys_fchmodat+0xc2/0xef
>  [<c015508f>] sys_lchown+0x50/0x52
>  [<c016231b>] do_getname+0x4b/0x73
>  [<c0165c45>] sys_renameat+0x47/0x73
>  [<c0165c98>] sys_rename+0x27/0x2b
>  [<c0102ae3>] syscall_call+0x7/0xb
> xfs_force_shutdown(dm-51,0x8) called from line 1139 of file
> fs/xfs/xfs_trans.c.  Return address = 0xc0229395
> Filesystem "dm-51": Corruption of in-memory data detected.  Shutting
> down filesystem: dm-51
> Please umount the filesystem, and rectify the problem(s)
> xfs_force_shutdown(dm-51,0x1) called from line 424 of file
> fs/xfs/xfs_rw.c.  Return address = 0xc0229395
>
> I was doing an lvmextend +xfs_resize of a different (XFS) filesystem
> on the same server at roughly the same time. But I'm not sure if
> that's related.
>
> I'm currently running xfs_repair on the fs that blew up.
>

I think lvextend and xfs_growfs are not the cause of the problem since
I've extended 6 more filesystems since one of them blew up and the
problem reported above has not manifested itself again (yet).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
