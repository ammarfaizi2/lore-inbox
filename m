Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWCCUQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWCCUQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWCCUQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:16:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932139AbWCCUQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:16:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> 
References: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>  <32518.1141401780@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: Memory barriers and spin_unlock safety 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 20:15:35 +0000
Message-ID: <5001.1141416935@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> The rules are, afaik, that reads can pass buffered writes, BUT WRITES 
> CANNOT PASS READS (aka "writes to memory are always carried out in program 
> order").

So in the example I gave, a read after the spin_unlock() may actually get
executed before the store in the spin_unlock(), but a read before the unlock
will not get executed after.

> No. Issuing a read barrier on one CPU will do absolutely _nothing_ on the 
> other CPU.

Well, I think you mean will guarantee absolutely _nothing_ on the other CPU for
the Linux kernel.  According to the IBM powerpc book I have, it does actually
do something on the other CPUs, though it doesn't say exactly what.

Anyway, thanks.

I'll write up some documentation on barriers for inclusion in the kernel.

David
