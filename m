Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRBTT2L>; Tue, 20 Feb 2001 14:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRBTT2A>; Tue, 20 Feb 2001 14:28:00 -0500
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:21742
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S129643AbRBTT1x>; Tue, 20 Feb 2001 14:27:53 -0500
Date: Tue, 20 Feb 2001 00:02:48 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [help] _syscall2 fails with -fPIC
Message-ID: <20010220000247.A1537@bacchus.dhis.org>
In-Reply-To: <20010217194709.283.qmail@web1304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217194709.283.qmail@web1304.mail.yahoo.com>; from swansma@yahoo.com on Sat, Feb 17, 2001 at 11:47:09AM -0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 11:47:09AM -0800, Mark Swanson wrote:

> I am building a -fPIC shared object that will define and access a Linux
> kernel system call, but _syscall2 fails with -fPIC .so compilation.
> What can I do?
>  
>         F.E. the statement:
>  
> _syscall2 (int, tux, unsigned int, action, user_req_t *, req)
>  
> Gives the following gcc error when compiled with -fPIC:
>  
> tst.c: In function `tux':
> tst.c:62: Invalid `asm' statement:
> tst.c:62: fixed or forbidden register 3 (bx) was spilled for class
> BREG.
> 
> If the -fPIC isn't there it compiles fine. Unfortunately I need to find
> another way as I have to use -fPIC.

Don't use the syscallX macros whenever possible; there are all sorts of
portability problems hidden there.  Their primary use is for within the
kernel; any other use should be considered problematic.  The prefered
solution is putting the necessary stubs into libc; if that doesn't seem
to be an option in your case try using the syscall() function defined in
<unistd.h> like:

#include <sys/syscall.h>
#include <unistd.h>

int main(char *argc, char *argv[])
{
	syscall(SYS_write, 1, "Hello, world\n", 13);
}

  Ralf
