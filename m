Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWFMWVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWFMWVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWFMWVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:21:33 -0400
Received: from hera.kernel.org ([140.211.167.34]:3801 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964775AbWFMWVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:21:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -mm] i386 syscall opcode reordering (pipelining)
Date: Tue, 13 Jun 2006 15:21:27 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6ndp7$58a$1@terminus.zytor.com>
References: <20060613195446.GD24167@rhlx01.fht-esslingen.de> <448F1B97.3070207@linux.intel.com> <e6nd68$4sq$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150237287 5387 127.0.0.1 (13 Jun 2006 22:21:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 13 Jun 2006 22:21:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <e6nd68$4sq$1@terminus.zytor.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> Probably not.  The _syscallN() macros are broken for the general case
> on any 32-bit architecture, since they can't handle multiregister
> arguments.
> 
> Similarly, a general syscall() function is broken (in the sense that
> one would have to have syscall-specific code to mangle the arguments)
> on *some*, but not all, 32-bit architectures, since some architectures
> have alignment constraints on multiregister arguments, and the syscall
> number argument throws off that alignment.
> 

I should probably add that it is possible to write _syscallN() macros
that handle multiregister arguments correctly; just the current ones
aren't done correctly.  The complexity gets pretty staggering for the
higher argument counts, though, as for each _syscallN() you have to
support 2^N possible cases, just to deal with 32- and 64-bit arguments
(which is all we support at this point, so it'd be okay.)

	-hpa
