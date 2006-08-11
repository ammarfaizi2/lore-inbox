Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWHKKZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWHKKZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWHKKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:25:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:9291 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932080AbWHKKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tll/8d1Xb/XSMctG0uZWchaJ7XNsTiVA12mKX3sJ3z9e1YyOEoc7hy6SVhMOw5oJnv8upNNMuXBLcY1U124xW40YGWnF7Sy+agGtcleL15ropwPjutcpKInVYgrJHehPNTNIlyDXBTg5m4x9sCNFMAYMWST3fVGDY1gd2PYgiKg=
Message-ID: <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>
Date: Fri, 11 Aug 2006 12:25:03 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: "Avuton Olrich" <avuton@gmail.com>, "Tony. Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
	 <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>
	 <20060808134438.E2526901@wobbly.melbourne.sgi.com>
	 <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>
	 <20060808185405.B2528231@wobbly.melbourne.sgi.com>
	 <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
	 <20060811083546.B2596458@wobbly.melbourne.sgi.com>
	 <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
	 <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com>
	 <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 11/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 11/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > On 11/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > > On Thu, Aug 10, 2006 at 01:31:35PM +0200, Jesper Juhl wrote:
> > > > > On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > > > ...
> > > > > Ok, I booted the server with 2.6.18-rc4 + your patch. Things went well
> > > > > for ~3 hours and then blew up - not in the same way though.
> > > > >
> > > > > The machine was under pretty heavy load recieving data via rsync when
> > > > > the following happened :
> > > > >
> > > > > Filesystem "dm-51": XFS internal error xfs_trans_cancel at line 1138
> > > > > of file fs/xfs/xfs_trans.c.  Caller 0xc0210e3f
> > > > >  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
> > > > >  [<c0103a5e>] show_trace+0xf/0x13
> > > > >  [<c0103b59>] dump_stack+0x15/0x19
> > > > >  [<c0213474>] xfs_trans_cancel+0xcf/0xf8
> > > > >  [<c0210e3f>] xfs_rename+0x64d/0x936
> > > > >  [<c0226286>] xfs_vn_rename+0x48/0x9f
> > > > >  [<c016584e>] vfs_rename_other+0x99/0xcb
> > > > >  [<c0165a36>] vfs_rename+0x1b6/0x1eb
> > > > >  [<c0165bda>] do_rename+0x16f/0x193
> > > > >  [<c0165c45>] sys_renameat+0x47/0x73
> > > >
> > > > Thanks Jesper.  Hmm, lessee - this is a cancelled dirty rename
> > > > transaction ... could be ondisk dir2 corruption (any chance this
> > > > filesystem was affected by 2.6.17's endian bug?)
> > >
> > > No. The machine in question never ran any 2.6.17.* kernels. Its old
> > > kernel was 2.6.11.11 (UP), then I tried 2.6.18-rc3-git3 (SMP) as
> > > previously reported, then I tried 2.6.18-rc4 + your XFS patch.
> > >
> > > >, or something
> > > > else entirely.  No I/O errors in the system log earlier or anything
> > > > like that?
> > > >
> > > No I/O errors in the logs that I could find, no.
> > >
> > >
> > > > > I was doing an lvmextend +xfs_resize of a different (XFS) filesystem
> > > > > on the same server at roughly the same time. But I'm not sure if
> > > > > that's related.
> > > >
> > > > That wont be related, no.
> > > >
> > > > > I'm currently running xfs_repair on the fs that blew up.
> > > >
> > > > OK, I'd be interested to see if that reported any directory (or
> > > > other) issues.
> > > >
> > > It did not.
> > >
> > > What happened was this (didn't save the output sorry, so the below is
> > > from memory) ;
> > > When I ran xfs_repair it first asked me to mount the filesystem to
> > > replay the log, then unmount it again, then run xfs_repair again. I
> > > did that. No errors during that mount or umount.
> > > Then, when I ran xfs_repair again it ran through phases 1..n (spending
> > > aproximately 1hour on this) without any messages saying that something
> > > was wrong, so when it was done I tried mounting the fs again and it
> > > said it did a mount of a clean fs.
> > > It's been running fine since.
> > >
> > Btw, I have left the machine running with the 2.6.18-rc4 kernel and it
> > can keep running that for ~11hrs more (I'll ofcourse let you know if
> > errors show up during the night)
>
> It blew up again. Same filesystem again + a new one :
>
> Filesystem "dm-31": XFS internal error xfs_trans_cancel at line 1138
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
> xfs_force_shutdown(dm-31,0x8) called from line 1139 of file
> fs/xfs/xfs_trans.c.  Return address = 0xc0229395
> Filesystem "dm-31": Corruption of in-memory data detected.  Shutting
> down filesystem: dm-31
> Please umount the filesystem, and rectify the problem(s)
> xfs_force_shutdown(dm-31,0x1) called from line 424 of file
> fs/xfs/xfs_rw.c.  Return address = 0xc0229395
> Filesystem "dm-31": Disabling barriers, not supported with external log device
> XFS mounting filesystem dm-31
> Starting XFS recovery on filesystem: dm-31 (logdev: /dev/Log/ws1_log)
> Ending XFS recovery on filesystem: dm-31 (logdev: /dev/Log/ws1_log)
> Filesystem "dm-31": Disabling barriers, not supported with external log device
> XFS mounting filesystem dm-31
> Ending clean XFS mount for filesystem: dm-31
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
> Filesystem "dm-31": XFS internal error xfs_trans_cancel at line 1138
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
> xfs_force_shutdown(dm-31,0x8) called from line 1139 of file
> fs/xfs/xfs_trans.c.  Return address = 0xc0229395
> Filesystem "dm-31": Corruption of in-memory data detected.  Shutting
> down filesystem: dm-31
> Please umount the filesystem, and rectify the problem(s)
>

I didn't capture all of the xfs_repair output, but I did get this :

        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - clear lost+found (if it exists) ...
        - clearing existing "lost+found" inode
        - deleting existing "lost+found" entry
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
LEAFN node level is 1 inode 412035424 bno = 8388608
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
