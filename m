Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTBXOJc>; Mon, 24 Feb 2003 09:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBXOJc>; Mon, 24 Feb 2003 09:09:32 -0500
Received: from crack.them.org ([65.125.64.184]:21139 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267153AbTBXOJb>;
	Mon, 24 Feb 2003 09:09:31 -0500
Date: Mon, 24 Feb 2003 09:16:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: fcorneli@elis.rug.ac.be
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.rug.ac.be
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
Message-ID: <20030224141608.GA24699@nevyn.them.org>
Mail-Followup-To: fcorneli@elis.rug.ac.be, linux-kernel@vger.kernel.org,
	Frank.Cornelis@elis.rug.ac.be
References: <Pine.LNX.4.44.0302241448140.1277-100000@tom.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241448140.1277-100000@tom.elis.rug.ac.be>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 03:05:14PM +0100, fcorneli@elis.rug.ac.be wrote:
> Hi,
> 
> I ported some generic SunOS ptrace requests from my 2.4 exptrace kernel 
> patch to the 2.5 tree. The PTRACE_READDATA/WRITEDATA requests have been 
> available for a long time for the sparc architecture but I think they're 
> also very useful on the i386 arch since PTRACE_PEEKDATA/POKEDATA are way 
> too slow when handling large data blocks.

FYI Frank, three things.  First of all, I really don't like the
interface of adding a second address to ptrace; I believe it interferes
with PIC on x86, since IIRC the extra argument would go in %ebx.  The
BSDs have a nice interface involving passing a request structure. 
Secondly, the implementation should be in kernel/ptrace.c not under
i386, we're trying to stop doing that.

Thirdly, I was going to do this, but I ended up making GDB use pread64
on /dev/mem instead.  It works with no kernel modifications, and is
just as fast.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
