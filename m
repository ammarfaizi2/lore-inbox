Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSHDKcu>; Sun, 4 Aug 2002 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSHDKcu>; Sun, 4 Aug 2002 06:32:50 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:15718 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318144AbSHDKct>; Sun, 4 Aug 2002 06:32:49 -0400
Date: Sun, 4 Aug 2002 13:36:04 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.30: buffer layer error at page-writeback.c:417
Message-ID: <20020804103604.GE1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <200208020726.51659.tomlins@cam.org> <20020803190734.GB1548@niksula.cs.hut.fi> <20020804081452.GC1548@niksula.cs.hut.fi> <3D4CE7C2.A2393F19@zip.com.au> <20020804092543.GD1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020804092543.GD1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 12:25:43PM +0300, you [Ville Herva] wrote:
> On Sun, Aug 04, 2002 at 01:37:22AM -0700, you [Andrew Morton] wrote:
> > Ville Herva wrote:
> > > 
> > > buffer layer error at page-writeback.c:417
> > > Pass this trace through ksymoops for reporting
> > 
> > Is that on the ramdisk driver?
> 
> (I should warn that this is on vmware - I don't dare to boot 2.5 on bare
> metal yet).
> 
> I do have ramdisk mounted:
> 
> /dev/ram0 /mounts ext2 rw 0 0

Ok, clean boot, no ramdisk, no errors.

Then I did 
mkfs /dev/ram0; mount /dev/ram0 /mounts; cd /mounts; tar xzf /mounts.tgz

and then:

root@linux3:/>umount mounts
buffer layer error at page-writeback.c:417
Pass this trace through ksymoops for reporting
c12bfe54 000001a1 c3d1b0e0 c1009640 c3d1b0e0 c1009640 c12bfe7c c012a2db
       c1009640 c1009648 c12bfecc c0159ae9 c1009640 c01095f4 00000000 c3e7fc74
       c3e7fc74 c12be000 c12be000 c12be000 c3d1b108 c3d1b0f8 c012a280 00000000
Call Trace: [<c012a2db>] [<c0159ae9>] [<c01095f4>] [<c012a280>] [<c0139697>]
   [<c012a309>] [<c013d853>] [<c013d8da>] [<c01416da>] [<c014214d>] [<c0154b24>]

Trace; c012a2db <fail_writepage+5b/70>
Trace; c0159ae9 <mpage_writepages+269/310>
Trace; c01095f4 <common_interrupt+18/20>
Trace; c012a280 <fail_writepage+0/70>
Trace; c0139697 <do_writepages+37/40>
Trace; c012a309 <filemap_fdatawrite+19/20>
Trace; c013d853 <sync_blockdev+23/50>
Trace; c013d8da <fsync_super+5a/90>
Trace; c01416da <generic_shutdown_super+4a/1b0>
Trace; c014214d <kill_block_super+1d/50>
Trace; c0154b24 <free_vfsmnt+24/40>

(Last time I didn't yet umount ramdisk.)


-- v --

v@iki.fi
