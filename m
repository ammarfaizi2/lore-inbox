Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKBAnX>; Fri, 1 Nov 2002 19:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbSKBAnX>; Fri, 1 Nov 2002 19:43:23 -0500
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:51864
	"EHLO www.piet.net") by vger.kernel.org with ESMTP
	id <S265815AbSKBAnW>; Fri, 1 Nov 2002 19:43:22 -0500
Subject: Re: What's left over. - Dave's crash code supports a gdb interface
	for LKCD crash dumps.
From: Piet Delaney <piet@www.piet.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Anderson <anderson@redhat.com>, kgdb@vsnl.net,
       Linus Torvalds <torvalds@transmeta.com>, piet <piet@www.piet.net>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <3DC17354.943DAC97@digeo.com>
References: <Pine.LNX.4.44.0210310900130.20412-100000@nakedeye.aparity.com>
	<Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> 
	<3DC17354.943DAC97@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 16:49:29 -0800
Message-Id: <1036198169.1580.126.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 10:15, Andrew Morton wrote:
 
> (Disclaimer: I've never used lkcd.  I'm assuming that it's
> possible to gdb around in a dump)

I updated Dave Anderson's (Mission Critical) crash code to work 
with LKCD core dumps when I updated LKCD to support the ia64. 
Dave's crash code uses gdb as a command interpreter. It's not quite 
as flexible as using gdb macros on core dumps but it's very close 
and has lots of support for various kernel structures. For example, 
you can't just have ddd walk through data structures by simply 
clicking on pointers in data structures like you normally can.
 
> 
> >         In particular when it comes to this project, I'm told about
> >         "netdump", which doesn't try to dump to a disk, but over the net.
> 
> It could help.  But like serial console, the random person whose
> kernel just died often can't be bothered setting it up, or simply
> doesn't have the gear, or the crash is not repeatable.

Yes, ideally I'd like to have an integration between live gdb stub
debugging and crash debugging. I'd like to even be able to use ddd/gdb
on a core file and simulate execution. When using gdb on the kernel 
I've found it nice to move the cursor over the PC and move it to the 
end of panic(). Then single step back out of panic and re-execute 
the code that returned the error code that caused us to decide to panic.
Doing this in asm language with a asm debugger is too difficult for 
most folks.

I really liked HP's kwdb approach. kwdb has a tiny TCP/IP stack and
has direct hooks into the trap vectors like a normal kgdb stub. The
nice thing is you can attach to a crash system over the internet
from anywhere in the world to debug the panic. I wasn't able to get
HP to release the kwdb gdb stub into the public domain. The gdb hacks
are available at:
 
http://h21007.www2.hp.com/dspp/tech/tech_TechSoftwareDetailPage_IDX/1,1703,257,00.html

but are based on a very old version of gdb and ia64 libraries.
	


> So.  _If_ lkcd gives me gdb-able images from time-of-crash, I'd
> like it please.  And I'm the grunt who spent nearly two years
> doing not much else apart from working 2.3/2.4 oops reports.

You can snarf a copy from:

	ftp://people.redhat.com/anderson

One area that I'm not sure of is if the lkcd kernel changes are a
problem with the kgdb patch (http://kgdb.sourceforge.net/). Perhaps
I can check into that in the near future.

I'd prefer to have both kgdb (http://kgdb.sourceforge.net/)
remote debugging and kgdb crash support available in stock kernels 
like the BSD kernels (NetBSD, FreeBSD). I don't know why the kgdb 
stub wasn't integrated into the kernel for the ia32 and ia64 platforms.
I suppose for reasons like we are hearing now on the LKCD kernel hooks.
The current LKCD code is at least a step in that direction.

-- 
piet@www.piet.net

