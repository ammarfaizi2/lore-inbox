Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314645AbSEVVr1>; Wed, 22 May 2002 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEVVr0>; Wed, 22 May 2002 17:47:26 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:49674 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S314645AbSEVVrX>; Wed, 22 May 2002 17:47:23 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BC1.0076F247.00@smtpnotes.altec.com>
Date: Wed, 22 May 2002 15:00:15 -0500
Subject: Re: Linux-2.5.17
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for pointing me in the right direction; I found the same code in my copy
of libgtop (1.0.9) and see the problem.  Maybe now I can hack something together
to make it work.

In comparing /proc/meminfo in 2.4.19-pre8 and 2.5.17 I see that there is very
little difference except that the information gtop relies upon is missing.  The
lines it needs aren't changed or rearranged, just gone altogether.  Was there
any particular purpose for that, other than breaking programs like gtop?  I'm a
firm believer that adding something new to a system should never break existing
functionality unless absolutely necessary.  Was it necessary in this case, or
was it done because someone was offended that it wasn't "clean" enough?





Nick.Holloway@pyrites.org.uk (Nick Holloway) on 05/22/2002 06:49:59 AM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Linux-2.5.17



In <86256BC1.001146A6.00@smtpnotes.altec.com> Wayne.Brown@altec.com writes:
> I can live with not building, crashing, or even eating filesystems.  Those
> things will be fixed sooner or later.  But breaking userspace programs -- that
> may well be permanent.

Looking at the source code to libgtop-1.0.6 (the version I have
easy access to), the parser used to extract the swap information from
/proc/meminfo is extremely fragile (read: broken).  Rather than looking
at the tag at the start of each line for the one it requires, it assumes
that the "Swap:" details are on the 3rd line (and doesn't even verify
the label).

You can't expect the kernel to keep compatability for such poor user-space
code (especially during a development cycle).

The change to /proc/meminfo came about in 2.5.1, and this removed
the first two lines from the old, inflexible layout (that has been
deprecated for a while, and should probably been removed during the
2.1.x development cycle).

--
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




