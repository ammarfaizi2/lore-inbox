Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTJJSai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJJSai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:30:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53148
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263121AbTJJSag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:30:36 -0400
Date: Fri, 10 Oct 2003 20:31:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010183101.GG16013@velociraptor.random>
References: <20031010172001.GA29301@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org> <20031010180535.GE29301@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010180535.GE29301@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:05:35AM -0700, Joel Becker wrote:
> thinking, knowing now that there's possibility to move to a more optimal
> interface.

cleaner and simpler could very well be (many simpler db works that way
infact), but more optimal I doubt. To be more optimal you should let the
kernel do all the garbage collection of mappings, and not use
remap_file_pages. But then I'm unsure if the kernel is really able
better than you to choose what info to discard from the cache, and you'd
still have to pay for page faults that you don't have to right now.

And if you use remap_file_pages to still choose what to ""discard
first"" from userspace, then you'd better use O_DIRECT instead, that
doesn't require any pte mangling (ignoring the readahead, async-io and
msync, scsi-shared issues that sounds fixable).

About the security issues, they existed in older kernels they're
nowadays fixed thanks to Stephen's i_alloc_sem.

though, I'd be interesting to compared different models in practice to
be sure, I just don't have expectations for it being a "more optimal"
design at the moment.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
