Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRD1Hej>; Sat, 28 Apr 2001 03:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRD1He3>; Sat, 28 Apr 2001 03:34:29 -0400
Received: from chiara.elte.hu ([157.181.150.200]:33295 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131949AbRD1HeW>;
	Sat, 28 Apr 2001 03:34:22 -0400
Date: Sat, 28 Apr 2001 09:32:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: X15 alpha release: as fast as TUX but in user space
Message-ID: <Pine.LNX.4.33.0104280923520.12895-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, Fabio Riccardi wrote:

> I'd like to announce the first release of X15 Alpha 1, a _user space_
> web server that is as fast as TUX.

great, the first TUX clone! ;-)

This should put the accusations to rest that Linux got the outstandingly
high SPECweb99 scores only because the webserver was in kernel-space. It's
the 2.4 kernel's high performance that enabled those results, having the
web-server in kernel-space didnt have much effect. TUX was and remains a
testbed to test high-performance webserving (and FTP serving), without the
API-exporting overhead of userspace.

[i suspect the small performance advantage of X15 is due to subtle
differences in the SPECweb99 user-space module: eg. while the TUX code was
written, tested and ready to use mmap()-enabled
TUXAPI_alloc_read_objectbuf(), it wasnt enabled actually. I sent Fabio a
mail how to enable it, perhaps he can do some tests to confirm this
suspicion?]

doing a TUX 2.0 SPECweb99 benchmark on the latest -ac kernels, 86% of time
is spent in generic parts of the kernel, 12% of time is spent in the
user-space SPECweb99 module, and only 2% of time is spent in TUX-specific
kernel code.

doing the same test with the original TUX 1.0 code shows that more than
50% of CPU time was spent in TUX-specific code.

what does this mean? In the roughly 6 months since TUX 1.0 was released,
we moved much of the TUX 1.0 -only improvements into the generic kernel
(most of which was made available to user-space as well), and TUX itself
became smaller and smaller (and used more and more generic parts of the
kernel). So in effect X15 is executing 50% TUX code :-)

(there are still a number of performance improvement patches pending that
are not integrated yet: the pagecache extreme-scalability patch and the
smptimers patch. These patches speed both X15 and TUX up.)

(there is one thing though that can never be 'exported to user-space': to
isolate possibly untrusted binary application code from the server itself,
without performance degradation. So we always have to be mentally open to
the validity of kernel-space services.)

	Ingo

