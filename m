Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbSKEBNL>; Mon, 4 Nov 2002 20:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKEBNL>; Mon, 4 Nov 2002 20:13:11 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28813 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267641AbSKEBNK>;
	Mon, 4 Nov 2002 20:13:10 -0500
Date: Mon, 04 Nov 2002 17:14:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <1118170000.1036458859@flay>
In-Reply-To: <20021105000010.GA21914@pegasys.ws>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Clearly ps could do with a cleanup.  There is no reason to
> read environ if it wasn't asked for.   Deciding which files
> are needed based on the command line options would be a
> start.
> 
> I'm thinking that ps, top and company are good reasons to
> make an exception of one value per file in proc.  Clearly
> open+read+close of 3-5 "files" each extracting data from
> task_struct isn't more efficient than one "file" that
> generates the needed data one field per line.

I think it's pretty trivial to make /proc/<pid>/psinfo, which
dumps the garbage from all five files in one place. Which makes
it 5 times better, but it still sucks.
 
> Don't get me wrong.  I believe in the one field per file
> rule but ps &co are the exception that proves (tests) the
> rule.  Especially on the heavily laden systems with
> tens of thousands of tasks.  We could do with a something
> between /dev/kmem and five files per pid.

I had a very brief think about this at the weekend, seeing
if I could make a big melting pot /proc/psinfo file that did
seqfile and read everything out in one go, using seq_file
internally to interate over the tasklist. The most obvious
problem that sprung to mind seems to be the tasklist locking -
you obviously can't just hold a lock over the whole thing.
As I know very little about that, I'll let someone else suggest
how to do this, but I'm prepared to do the grunt work of implementing
it if need be.

M.

