Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUDSAju (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUDSAju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:39:50 -0400
Received: from florence.buici.com ([206.124.142.26]:27011 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264226AbUDSAjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:39:48 -0400
Date: Sun, 18 Apr 2004 17:39:47 -0700
From: Marc Singer <elf@buici.com>
To: Rik van Riel <riel@redhat.com>
Cc: Marc Singer <elf@buici.com>, Andrew Morton <akpm@osdl.org>,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040419003947.GA15958@flea>
References: <20040418061529.GF19595@flea> <Pine.LNX.4.44.0404182025290.10183-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404182025290.10183-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 08:26:13PM -0400, Rik van Riel wrote:
> On Sat, 17 Apr 2004, Marc Singer wrote:
> 
> > I thought I sent a message about this.  I've found that the problem
> > *only* occurs when there is exactly one process running.
> 
> BINGO!  ;)
> 
> Looks like this could be the referenced bits not being
> flushed from the MMU and not found by the VM...

Can you be a little more verbose for me?  The ARM MMU doesn't keep
track of page references, AFAICT.  How does a context switch change
this?  

I have looked into the case where the TLB for an old page isn't being
flushed (by design), but I've been unable to fix the problem by
forcing a TLB flush whenever a PTE is zeroed.

