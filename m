Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWCULjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWCULjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWCULjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:39:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030350AbWCULjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:39:22 -0500
Date: Tue, 21 Mar 2006 11:39:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [0/3] Kprobes: User space probes support
Message-ID: <20060321113912.GC5460@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>, akpm@osdl.org,
	Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
	richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
References: <20060320060745.GC31091@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320060745.GC31091@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 11:37:45AM +0530, Prasanna S Panchamukhi wrote:
> This patch set provides the basic infrastructure for user-space probes
> based on IBM's Dprobes. Similar to kprobes, user-space probes uses the
> breakpoint mechanism to insert probes. User has to write a kernel module
> to insert probes in the executable/library and specify the handlers in
> the kernel module.

Doing this from kernelspace is wrong.  It should be done from userspace,
best using a systemcall. Of couse the handlers can't work as-is you'd
need to redo that to work similarlt to ptrace - which will hopefully
allow some code reuse aswell.


And please - independent of the best api in this case - please don't ever
submit large amounts of code again that don't have any in-tree user.
