Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWH2SbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWH2SbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWH2SbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:31:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965203AbWH2SbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:31:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608292018.01602.ak@suse.de> 
References: <200608292018.01602.ak@suse.de>  <44F395DE.10804@yahoo.com.au> <200608291922.04354.ak@suse.de> <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com> 
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 19:30:59 +0100
Message-ID: <809.1156876259@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> BTW maybe it would be a good idea to switch the wait list to a hlist,
> then the last user in the queue wouldn't need to 
> touch the cache line of the head. Or maybe even a single linked
> list then some more cache bounces might be avoidable.

You need a list_head to get O(1) push at one end and O(1) pop at the other.
In addition a singly-linked list makes interruptible ops non-O(1) also.

David
