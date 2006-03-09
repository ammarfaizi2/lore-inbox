Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWCIA7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWCIA7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWCIA7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:59:23 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:16618 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1030211AbWCIA7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:59:22 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 16:59:05 -0800
User-Agent: KMail/1.9.1
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20060308184500.GA17716@devserv.devel.redhat.com> <20060308194037.GO7301@parisc-linux.org> <17423.30924.278031.151438@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.30924.278031.151438@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081659.05786.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 8, 2006 4:37 pm, Paul Mackerras wrote:
> Matthew Wilcox writes:
> > Looking at the SGI implementation, it's smarter than you think. 
> > Looks like there's a register in the local I/O hub that lets you
> > determine when this write has been queued in the appropriate
> > host->pci bridge.
>
> Given that mmiowb takes no arguments, how does it know which is the
> appropriate PCI host bridge?

It uses a per-node address space to reference the local bridge.  The 
local bridge then waits until the remote bridge has acked the write 
before, then sets the outstanding write register to the appropriate 
value.

Jesse
