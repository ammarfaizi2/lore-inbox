Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAEXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAEXhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAEXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:37:23 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26851 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932272AbWAEXhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:37:21 -0500
Message-ID: <43BDAD8A.60108@austin.ibm.com>
Date: Thu, 05 Jan 2006 17:36:42 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <Pine.LNX.4.64.0601051523060.3169@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601051523060.3169@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Here is a first pass at a powerpc file for the fast paths just as an FYI/RFC.
>>It is completely untested, but compiles.
> 
> 
> Shouldn't you make that "isync" dependent on SMP too? UP doesn't need it, 
> since DMA will never matter, and interrupts are precise.
> 
> 		Linus
> 

I think the isync is necessary to keep heavily out of order processors from 
getting ahead of themselves even on UP.  Scanning back through the powerpc 
spinlock code they seem to take the same view there as well.
