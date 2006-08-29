Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWH2RZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWH2RZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWH2RZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:25:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:18078 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965156AbWH2RZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:25:04 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 19:22:04 +0200
User-Agent: KMail/1.9.3
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <44F395DE.10804@yahoo.com.au> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291922.04354.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 17:56, Christoph Lameter wrote:
> On Tue, 29 Aug 2006, David Howells wrote:
> 
> > Because i386 (and x86_64) can do better by using XADDL/XADDQ.
> 
> And Ia64 would like to use fetchadd....

This might be a dumb question, but I would expect even on altix 
with lots of parallel faulting threads rwsem performance be basically
limited by aquiring the cache line and releasing it later to another CPU.

Do you really think it will make much difference what particular atomic
operation is used? The basic cost of sending the cache line over the
interconnect should be all the same, no? And once the cache line is local
it should be reasonably fast either way.

> > CMPXCHG is not available on all archs, and may not be implemented on all archs
> > through other atomic instructions.
> 
> Which arches do not support cmpxchg?

parisc at least iirc (it practically doesn't support very much atomically)
and likely sparcv8.

-Andi 
