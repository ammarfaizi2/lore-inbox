Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLTRao>; Fri, 20 Dec 2002 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLTRao>; Fri, 20 Dec 2002 12:30:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28420 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262859AbSLTRan>; Fri, 20 Dec 2002 12:30:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PTRACE_GET_THREAD_AREA
Date: Fri, 20 Dec 2002 17:36:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <atvkf5$6io$1@penguin.transmeta.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com> <20021220102431.A26923@infradead.org>
X-Trace: palladium.transmeta.com 1040405904 31580 127.0.0.1 (20 Dec 2002 17:38:24 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Dec 2002 17:38:24 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021220102431.A26923@infradead.org>,
Christoph Hellwig  <hch@infradead.org> wrote:
>
>I don't think ptrace is the right interface for this.  Just changed
>the get_thread_area/set_thread_area to take a new first pid_t argument.

No.  There is _no_ excuse for even looking at (much less changing)
another process' thread area unless you are tracing that process. 

Basically, there is only _one_ valid user of getting/setting the thread
area of somebody else, and that's for debugging. And debuggers use
ptrace. It's as simple as that. They use ptrace to read and set memory
contents, they use ptrace to read and set registers, and they should use
ptrace to check status bits of the process.

We do not introduce any extensions to existing system calls for
debuggers. We already have the interface, and one that does a lot better
at checking permissions in _one_ place than it would be to have magic
"can this process read/modify another process" things.

		Linus
