Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJQDyY>; Wed, 16 Oct 2002 23:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSJQDyY>; Wed, 16 Oct 2002 23:54:24 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:41862
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261689AbSJQDyX>; Wed, 16 Oct 2002 23:54:23 -0400
Subject: Re: Posix capabilities
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021017032619.GA11954@think.thunk.org>
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
	 <20021017032619.GA11954@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034827220.32333.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 23:00:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 22:26, Theodore Ts'o wrote:
> On Wed, Oct 16, 2002 at 05:44:59PM +0200, Stefan Schwandter wrote:
> > 
> > I saw capabilities and acl patches for ext2/3 enter -mm. Is it possible
> > now to give an executable (that lives on an ext2/ext3 fs) the necessary
> > rights to use SCHED_FIFO without being setuid root? Could someone give
> > me some pointers for these topics (capabilities support in linux, acl)?
> 
> The patchs which I've been working on do not support capabilities;
> just extended attributes. 
> 
> Personally, I'm not so convinced that capabilities are such a great
> idea.  System administrators have a hard enough time keeping 12 bits
> of permissions correct on executable files; with capabilities they
> have to keep track of several hundred bits of capabilties flags, which
> must be set precisely correctly, or the programs will either (a) fail
> to function, or (b) have a gaping huge security hole.  

While working with LIDS in it's early stages of implementation, and
having written some documentation around CAPs and  extended attributes,
as well as managing that environment, I see value in CAPs, but I see it
a difficult task to say, manage 100 servers with very tight CAPs set. 

> This probablem could be solved with some really scary, complex user
> tools (which no one has written yet). 

Looking at CA Unicenter, they have an ACLs and CAPs product which does
centralized management of those attributes to keep the configs sane
across your environment. Not trying to advertise for them, but the point
is, if a commercial product exists to do this, then it should be highly
possible in the OSS community as well.

>  Alternatively you could just
> let programs continue to be setuid root, but modify the executable to
> explicitly drop all the capabilities except for the ones that are
> actually needed as one of the first things that executable does.

To make management easy for the admins when I dealt with LIDS and making
it *very* tight, I had to write several wrappers, replace commands, etc
so they ran chrooted automatically, etc. It was a PITA. Cool when it
worked, but it was still a PITA.

> It perhaps only gives you 90% of the benefits of the full-fledged
> capabilities model, but it's much more fool proof, and much easier to
> administer.

Perhaps exntending the security module to actually have a centralized
host configuration utility, using say AES or diffie-hellman and SSL or
SSH to do the configuration management of this. Centralizing, or
distributing the management of this, but with a decided upon security
architecture is what, imho, will actually make this type of
configuration very useable, and manageable. 

> 						- Ted
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
