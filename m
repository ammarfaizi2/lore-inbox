Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUDUQch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUDUQch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDUQch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:32:37 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56840 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261186AbUDUQcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:32:36 -0400
Date: Wed, 21 Apr 2004 17:32:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421173233.A8176@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <OF5F328943.611CF55B-ONC1256E7D.005A1D57-C1256E7D.005ABDDC@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF5F328943.611CF55B-ONC1256E7D.005A1D57-C1256E7D.005ABDDC@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Apr 21, 2004 at 06:31:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 06:31:08PM +0200, Martin Schwidefsky wrote:
> > This is a bit ugly.  What about inlining the CONFIG_NO_IDLE_HZ case
> > of this function in it's only caller and define idle_cpu_mask to
> > an empty cpu mask for all other arches?
> 
> This would mean that all other arches need to do the above three
> statements in rcu_start_batch. If this is acceptable we certainly
> can introduce a global idle_cpu_mask. Where? sched.c?

My hope was gcc would actually optimize it away if it was a CPP constant
instead of a variable.

