Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSCUOCX>; Thu, 21 Mar 2002 09:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312213AbSCUOCN>; Thu, 21 Mar 2002 09:02:13 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:30223 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312169AbSCUOBx>;
	Thu, 21 Mar 2002 09:01:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15513.59145.678790.431319@gargle.gargle.HOWL>
Date: Fri, 22 Mar 2002 00:58:33 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] fcntl returns wrong error code
In-Reply-To: <E16o2cX-0005At-00@the-village.bc.nu>
X-Mailer: VM 7.03 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002/3/21 13:28+0000  Alan Cox writes:
> > When fcntl(fd, F_DUPFD, b) is called where 'b' is greater than the
> > maximum allowable value EINVAL should be returned. From POSIX:
> > 
> > "[EINVAL] The cmd argument is invalid, or the cmd argument is F_DUPFD and
> > arg is negative or greater than or equal to {OPEN_MAX}, or ..."
> 
> Where does it mention rlimit ? Also we sort of have a problem since
> OPEN_MAX is not a constant on Linux x86. I guess that means a libc enforced
> behaviour or something for that bit

In this case OPEN_MAX is defined as:

"3.167 File descriptor 

A per-process unique, non negative integer used to identify an open
file for the purpose of file access. The value of a file descriptor
is from zero to {OPEN_MAX}. A process can have no more than {OPEN_MAX} file
descriptors open simultaneously. File descriptors may also be used ...."

Also from the limit.h page in Headers section it mentions that "many
of the listed limits are not invariant, and at runtime, the value of
the limit may differ from those given in the header ..... <snip> ..
.. For these reasons an application may use the fpathconf(),
pathconf() and sysconf() functions to determine the actual value of a
limit at runtime."

So the standard does take into account that the value may not be
constant and (I think) that in the fcntl case the OPEN_MAX refers to
the actual runtime value, which is not necessarily the same as the
definition in limits.h.

This problem was picked up by the POSIX.1-1990 test suite which
does a sysconf(_SC_OPEN_MAX) to determine OPEN_MAX. 

btw Stephen Rothwell pointed out that there is a much neater way to
achieve the same change. I'll post a new patch in the morning.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
