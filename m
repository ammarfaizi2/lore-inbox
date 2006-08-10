Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHJWw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHJWw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWHJWw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:52:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:57290 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWHJWw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:52:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GKKjN/Hvtauz6oFSg0bPcESWJBBAiqZwrbN9047x2ne1pN4abXUXJVasJfoqtVsRZ1ryVKjugge0KvwL7GT89DyYIU5V60sA4TqvFRqnQYg7hEK2fxzc6Pggtx3ZZcbDaXaxt563zlXbpVFBQVz3K/1xeNx3+216/gvqQA06mao=
Message-ID: <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com>
Date: Fri, 11 Aug 2006 00:52:25 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: "Avuton Olrich" <avuton@gmail.com>, "Tony. Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
	 <44D56A97.2070603@idccenter.cn>
	 <20060807143416.A2501392@wobbly.melbourne.sgi.com>
	 <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>
	 <20060808134438.E2526901@wobbly.melbourne.sgi.com>
	 <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>
	 <20060808185405.B2528231@wobbly.melbourne.sgi.com>
	 <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
	 <20060811083546.B2596458@wobbly.melbourne.sgi.com>
	 <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 11/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Thu, Aug 10, 2006 at 01:31:35PM +0200, Jesper Juhl wrote:
> > > On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > ...
> > > Ok, I booted the server with 2.6.18-rc4 + your patch. Things went well
> > > for ~3 hours and then blew up - not in the same way though.
> > >
> > > The machine was under pretty heavy load recieving data via rsync when
> > > the following happened :
> > >
> > > Filesystem "dm-51": XFS internal error xfs_trans_cancel at line 1138
> > > of file fs/xfs/xfs_trans.c.  Caller 0xc0210e3f
> > >  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
> > >  [<c0103a5e>] show_trace+0xf/0x13
> > >  [<c0103b59>] dump_stack+0x15/0x19
> > >  [<c0213474>] xfs_trans_cancel+0xcf/0xf8
> > >  [<c0210e3f>] xfs_rename+0x64d/0x936
> > >  [<c0226286>] xfs_vn_rename+0x48/0x9f
> > >  [<c016584e>] vfs_rename_other+0x99/0xcb
> > >  [<c0165a36>] vfs_rename+0x1b6/0x1eb
> > >  [<c0165bda>] do_rename+0x16f/0x193
> > >  [<c0165c45>] sys_renameat+0x47/0x73
> >
> > Thanks Jesper.  Hmm, lessee - this is a cancelled dirty rename
> > transaction ... could be ondisk dir2 corruption (any chance this
> > filesystem was affected by 2.6.17's endian bug?)
>
> No. The machine in question never ran any 2.6.17.* kernels. Its old
> kernel was 2.6.11.11 (UP), then I tried 2.6.18-rc3-git3 (SMP) as
> previously reported, then I tried 2.6.18-rc4 + your XFS patch.
>
> >, or something
> > else entirely.  No I/O errors in the system log earlier or anything
> > like that?
> >
> No I/O errors in the logs that I could find, no.
>
>
> > > I was doing an lvmextend +xfs_resize of a different (XFS) filesystem
> > > on the same server at roughly the same time. But I'm not sure if
> > > that's related.
> >
> > That wont be related, no.
> >
> > > I'm currently running xfs_repair on the fs that blew up.
> >
> > OK, I'd be interested to see if that reported any directory (or
> > other) issues.
> >
> It did not.
>
> What happened was this (didn't save the output sorry, so the below is
> from memory) ;
> When I ran xfs_repair it first asked me to mount the filesystem to
> replay the log, then unmount it again, then run xfs_repair again. I
> did that. No errors during that mount or umount.
> Then, when I ran xfs_repair again it ran through phases 1..n (spending
> aproximately 1hour on this) without any messages saying that something
> was wrong, so when it was done I tried mounting the fs again and it
> said it did a mount of a clean fs.
> It's been running fine since.
>
Btw, I have left the machine running with the 2.6.18-rc4 kernel and it
can keep running that for ~11hrs more (I'll ofcourse let you know if
errors show up during the night), then I have to reboot it back to the
2.6.11.11 kernel that it is stable with and it will need to run that
until ~wednesday next week before I can do further experiments.
So, if you want me to test any patches I'll need to recieve them
within the next 10 or so hours if I'm to have a chance to run with
them for a few hours tomorrow - otherwise testing will have to wait
for next week.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
