Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbRGNSUD>; Sat, 14 Jul 2001 14:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbRGNSTy>; Sat, 14 Jul 2001 14:19:54 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11172 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264669AbRGNSTm>;
	Sat, 14 Jul 2001 14:19:42 -0400
Message-ID: <3B508D34.180A07A0@mandrakesoft.com>
Date: Sat, 14 Jul 2001 14:19:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: __KERNEL__ removal
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu>
	 <3B5083AE.71515696@mandrakesoft.com> <p05100309b77639cfaced@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> I take it the policy JG is referring to applies to including any
> kernel header files at all in userspace programs, and that __KERNEL__
> removal is a mere consequence of that policy.
> 
> AC points out that syscall interfaces in glibc are a reasonable
> exception to that policy.

> What about a header like ethtool.h? Isn't its whole reason for
> existing to provide a common ABI for ethtool.c and the various
> drivers that support it?

no.  this is counter to the
don't-include-kernel-headers-in-userspace-programs policy.

kernel types are not userspace types, kernel namespace isn't userspace
namespace.

> Likewise sockios.h, which ethtool (and no doubt many others) also
> #includes. Unless you're going to encapsulate all possible ioctl
> interfaces into libc, sockios.h (for example) provides a piece of the
> ABI that's needed by the user code, not just by libc. Why would it
> make sense to require retyping of this stuff?

> If, on the other hand, the argument is that user-kernel ABI
> definitions should be isolated in their own headers, and not mixed up
> (hence __KERNEL__), that's a much more restricted argument. My
> impression is that this is *not* the argument though; is it?

If there -must- be parts of the kernel that are visible to userspace,
yes, we should separate them and make that separation obvious.  I would
not call our current setup obvious :)

IMHO the current __KERNEL__ "policy" is largely unenforced...  It takes
no time at all to find any number of cases (drivers adding ioctls are
the worst) where a header is shared between userspace and kernelspace,
and it pollutes kernel types or structures to userspace, or vice versa.

If we want to avoid the retyping (which is IMHO the most clean
separation for all cases, even if it involves drudgery) then separating
out code into libc-only headers would be nice.

	Jeff


-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
