Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbQKFSzB>; Mon, 6 Nov 2000 13:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQKFSyw>; Mon, 6 Nov 2000 13:54:52 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:16289 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129331AbQKFSye>;
	Mon, 6 Nov 2000 13:54:34 -0500
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: George Talbot <george@brain.moberg.com>, Marc Lehmann <pcg@goof.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
In-Reply-To: <200011061655.LAA21681@tsx-prime.MIT.EDU>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 06 Nov 2000 10:50:37 -0800
In-Reply-To: "Theodore Y. Ts'o"'s message of "Mon, 6 Nov 2000 11:55:05 -0500"
Message-ID: <m33dh5aq9u.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@MIT.EDU> writes:

> Arguably though the bug is in glibc, in that if it's using signals
> behinds the scenes, it should have passed SA_RESTART to sigaction.

Why are you talking  such a nonsense?

> 
> However, from a portability point of view, you should *always* surround
> certain system calls with while loops, since even if your program
> doesn't use signals, if you run that program on a System-V derived Unix
> system, and someone types ^Z at the wrong moment, you can also get an
> EINTR.   Similarly, you should always check the return value from write
> and make sure all of what you asked to be written, was actually
> written.
> 
> What I normally do is have a full_write routine which looks something
> like this:
> 
> static errcode_t full_write(int fd, void *buf, int count)
> {
> 	char	*cp = buf;
> 	int	left = count, c;
> 
> 	while (left) {
> 		c = write(fd, cp, left);
> 		if (c < 0) {
> 			if (errno == EINTR || errno == EAGAIN)
> 				continue;
> 			return errno;
> 		}
> 		left -= c;
> 		cp += c;
> 	}
> 	return 0;
> }
> 
> It's like checking the return value from malloc().  Not everyone does
> it, but even if it's not needed 99% of the time, it's a darned good idea
> to do that.
> 
> 					- Ted
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
