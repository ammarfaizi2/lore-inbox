Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWFWSn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWFWSn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWFWSnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:43:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14784 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751915AbWFWSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:56 -0400
Date: Fri, 23 Jun 2006 19:41:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <clameter@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
Message-ID: <20060623184145.GA22172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Christoph Lameter <clameter@sgi.com>,
	Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	David Howells <dhowells@redhat.com>,
	Christoph Lameter <christoph@lameter.com>,
	Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
References: <20060619175243.24655.76005.sendpatchset@lappy> <20060619175253.24655.96323.sendpatchset@lappy> <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> <1151019590.15744.144.camel@lappy> <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org> <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com> <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com> <1151083338.30819.28.camel@lappy> <Pine.LNX.4.64.0606231055520.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606231055520.6483@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 10:56:44AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 23 Jun 2006, Peter Zijlstra wrote:
> > 
> > I intent to make swap over NFS work next.
> 
> Doesn't it work already? Is there some throttling that doesn't work?

With the current code it definitly doesn't.  The swap code calls ->bmap
to do block mappings at swapon time and then uses bios directly. This
obviously can't work on anything but blockdevice-based filesystems.
