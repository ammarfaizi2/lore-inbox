Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWFMWLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWFMWLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFMWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:11:50 -0400
Received: from hera.kernel.org ([140.211.167.34]:22913 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932277AbWFMWLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:11:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -mm] i386 syscall opcode reordering (pipelining)
Date: Tue, 13 Jun 2006 15:11:20 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6nd68$4sq$1@terminus.zytor.com>
References: <20060613195446.GD24167@rhlx01.fht-esslingen.de> <448F1B97.3070207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150236680 5019 127.0.0.1 (13 Jun 2006 22:11:20 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 13 Jun 2006 22:11:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <448F1B97.3070207@linux.intel.com>
By author:    Arjan van de Ven <arjan@linux.intel.com>
In newsgroup: linux.dev.kernel
>
> Andreas Mohr wrote:
> > Hi all,
> > 
> > I'd guess that this version features improved pipeline parallelism,
> > since we isolate competing %ebx accesses (_syscall4()) and
> > stack push operations (_syscall5()), right?
> 
> is anybody actually EVER using those???
> I would think not....

Probably not.  The _syscallN() macros are broken for the general case
on any 32-bit architecture, since they can't handle multiregister
arguments.

Similarly, a general syscall() function is broken (in the sense that
one would have to have syscall-specific code to mangle the arguments)
on *some*, but not all, 32-bit architectures, since some architectures
have alignment constraints on multiregister arguments, and the syscall
number argument throws off that alignment.

	-hpa

