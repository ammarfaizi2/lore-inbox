Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTADMEH>; Sat, 4 Jan 2003 07:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTADMEH>; Sat, 4 Jan 2003 07:04:07 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:16854 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S266977AbTADMEG>;
	Sat, 4 Jan 2003 07:04:06 -0500
Message-ID: <3E16DD2A.2BCDE86B@tin.it>
Date: Sat, 04 Jan 2003 13:10:02 +0000
From: "A.D.F." <adefacc@tin.it>
Reply-To: adefacc@tin.it
Organization: Private
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP Zero Copy for mmapped files
References: <3E161DFD.AB8D25AE@tin.it> <20030104004153.GA16238@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> On 2003.01.04 A.D.F. wrote:
> > FreeBSD 5.0 should already have a zero copy for mmapped files and
> > IMHO it would be worth to have it in Linux 2.6 too.
> >
> > It would also be very nice to be able to enable zero copy for mmapped files
> > by a config option.
> >
> > Many applications use mapped memory to serve lots of small and
> > medium sized files (4 - 1024 KB) or even a few big files
> > (think at web servers, i.e. Apache 2, etc.);  this is done to better
> > serve multiple / parallel downloads being done on the same files.
> >
> 
> Apache2 uses mmap() to open files ??

No, you cannot use mmap() to open files ... :-),
at most mmap() helps caching static file contents in order
to avoid too many open() / close() calls (which maybe slow).

Apache 2 seems to use sendfile (in blocking mode) by default,
it uses mmap() only if you enable it (see also mod_file_cache).

Other web servers (i.e. Zeus) use widely mmap() for specific
file sizes, when it is usually a strong win (specially under *BSD and
Solaris)
in big / busy servers with lots of RAM.

> So then there is a reason to include it in my patchset...

Certainly yes (after required bug fixes :-)

-- 
Nick Name:      A.D.F.
E-Mail:         adefacc@tin.it
E-Mail-Font:    Courier New (plain text, no html)
--
