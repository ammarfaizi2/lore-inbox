Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbQKCPYj>; Fri, 3 Nov 2000 10:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130492AbQKCPY2>; Fri, 3 Nov 2000 10:24:28 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:55749 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129377AbQKCPYU>; Fri, 3 Nov 2000 10:24:20 -0500
Date: Fri, 3 Nov 2000 16:24:09 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Yann Dirson <ydirson@altern.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001103162409.S7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva> <20001101220326.A4514@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001101220326.A4514@bylbo.nowhere.earth>; from ydirson@altern.org on Wed, Nov 01, 2000 at 10:03:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 10:03:27PM +0100, Yann Dirson wrote:
> On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:
> > it appears there has been amazingly little research on this
> > subject and it's completely unknown which approach will work
> > "best" ... or even, what kind of behaviour is considered to
> > be best by the users...
> 
> Sounds to me like a good point to favour a config-time selection of
> OOM killers.

Better yet: Apply my OOM-Killer-API-Patch[1] and build your own
OOM-Killer!

Just lock your module into memory, supply an function to
install_oom_killer(), save the old one (you get it as return if
installing it went ok) and be happy.

And now have fun bringing your machine into OOM situations.

Want to change it back? No problem. Just get signaled somehow[2],
reinstall the old one, unlock your module and wait to be cleaned
up.

I never tried it above Riks 2.2.x-OOM-Killer-Patch, but it should
work on top of it, because oom_kill.c isn't all that different.

Regards

Ingo Oeser

[1] http://www.tu-chemnitz.de/~ioe/oom_kill_api.patch
[2] if you don't know that much about the kernel, you shouldn't
   play with oom-handlers anyway ;-)
-- 
Feel the power of the penguin - run linux@your.pc
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
