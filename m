Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286375AbSAAXon>; Tue, 1 Jan 2002 18:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286382AbSAAXoW>; Tue, 1 Jan 2002 18:44:22 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31947
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S286375AbSAAXoT>; Tue, 1 Jan 2002 18:44:19 -0500
Date: Tue, 1 Jan 2002 16:43:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:

> The appended patch fix incorrect code, which interferes badly with
> optimizations in GCC 3.0.4 and GCC 3.1.
> 
> The GCC tries to replace the strcpy from a constant string source with
> a memcpy, since the length is know at compile time.

Check the linuxppc-dev archives, but this has been discussed before, and
it came down to a few things.
1) gcc shouldn't be making this optimization, and Paulus (who wrote the
code) disliked this new feature.  As a subnote, what you sent was sent
to Linus with a comment about working around a gcc-3.0 bug/feature, and
was rejected because of this.
2) We could modify the RELOC macro, and not have this problem.  The
patch was posted, but not acted upon.
3) We could also try turning off this particular optimization
(-fno-builtin perhaps) on this file, and not worry about it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
