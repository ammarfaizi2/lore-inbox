Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSJVQfE>; Tue, 22 Oct 2002 12:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSJVQfE>; Tue, 22 Oct 2002 12:35:04 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:40260 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S264614AbSJVQfD>; Tue, 22 Oct 2002 12:35:03 -0400
Date: Tue, 22 Oct 2002 09:49:20 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@sgi.com>
cc: Piet Delaney <piet@www.piet.net>, <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@ocs.com.au>, <steiner@sgi.com>,
       <jeremy@classic.engr.sgi.com>
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
In-Reply-To: <20021022144745.A7367@sgi.com>
Message-ID: <Pine.LNX.4.44.0210220943290.24156-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Christoph Hellwig wrote:
|>On Mon, Oct 21, 2002 at 03:06:59PM -0700, Piet Delaney wrote:
|>> > Shouldn't much of this be static? again volatile is seldomly a good idea.
|>> 
|>> I suppose  with 'bio_complete' being an int changing it's value is
|>> atomic as long as it's treated a a volatile.Using a spinlock might
|>> be cleaner.
|>
|>an atomic_t or set_bit/test_bit/etc is used to be atomic in the kernel
|>if you don't want a lock.  And in this case a lock looks like overkill.

All of the volatile/atomic, C99, typedef, data format, return format,
u64/32/16/etc, are all addressed and fixed in the latest patches.  The
dump_bp() is removed for now, to be considered later if/when it makes
sense.

We'd want to keep the ioctl() interface, given the number of programs
using it across multiple platforms (and is being considered for
multiple OSes).  DUMP_MAJOR has changed to CRASH_DUMP_MAJOR and is
now standard in major.h.  Finally, the MAINTAINERS and Config.help
files are updated.

We're correcting a few more issues with the mem_map[], page_is_ram(),
etc., usage, but those shouldn't take long.

If anyone needs a preliminary patch this morning, let me know.

--Matt

P.S.  Pete, we can go through the dump_bp() stuff on the mailing list.

