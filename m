Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVA2QrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVA2QrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVA2QrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:47:12 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12297 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261391AbVA2QrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:47:05 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <41FBB821.3000403@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F95F79.6080904@comcast.net>
	 <1106862801.5624.145.camel@laptopd505.fenrus.org>
	 <41F96C7D.9000506@comcast.net>
	 <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
	 <41FB2DD2.1070405@comcast.net>
	 <1106986224.4174.65.camel@laptopd505.fenrus.org>
	 <41FBB821.3000403@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 17:46:58 +0100
Message-Id: <1107017218.4174.130.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 11:21 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> >>I actually just tried to paxtest a fresh Fedora Core 3, unadultered,
> >>that I installed, and it FAILED every test.  After a while, spender
> >>reminded me about PT_GNU_STACK.  It failed everything but the Executable
> >>Stack test after execstack -c *.  The randomization tests gave
> >>13(heap-etexec), 16(heap-etdyn), 17(stack), and none for main exec
> >>(etexec,et_dyn) or shared library randomization.
> > 
> > 
> > because you ran prelink.
> > and you did not compile paxtest with -fPIE -pie to make it a PIE
> > executable.
> > 

what I get is

Executable anonymous mapping             : Killed
Executable bss                           : Killed
Executable data                          : Vulnerable
Executable heap                          : Killed
Executable stack                         : Killed
Executable anonymous mapping (mprotect)  : Vulnerable
Executable bss (mprotect)                : Vulnerable
Executable data (mprotect)               : Vulnerable
Executable heap (mprotect)               : Vulnerable
Executable shared library bss (mprotect) : Vulnerable
Executable shared library data (mprotect): Vulnerable
Executable stack (mprotect)              : Vulnerable
Anonymous mapping randomisation test     : No randomisation
Heap randomisation test (ET_EXEC)        : 13 bits (guessed)
Heap randomisation test (ET_DYN)         : 13 bits (guessed)
Main executable randomisation (ET_EXEC)  : 12 bits (guessed)
Main executable randomisation (ET_DYN)   : 12 bits (guessed)
Shared library randomisation test        : 12 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
Return to function (strcpy)              : paxtest: bad luck, try
different compiler options.
Return to function (strcpy, RANDEXEC)    : paxtest: bad luck, try
different compiler options.
Return to function (memcpy)              : Vulnerable
Return to function (memcpy, RANDEXEC)    : Vulnerable
Executable shared library bss            : Killed
Executable shared library data           : Killed
Writable text segments                   : Vulnerable


I'm not entirely happy yet (it shows a bug in mmap randomisation) but
it's way better than what you get in your tests (this is the desabotaged
0.9.6 version fwiw)


