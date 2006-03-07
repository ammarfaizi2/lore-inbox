Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWCGSCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWCGSCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCGSCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:02:09 -0500
Received: from ns.suse.de ([195.135.220.2]:48599 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751436AbWCGSCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:02:07 -0500
From: Andi Kleen <ak@suse.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 11:34:52 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <31492.1141753245@warthog.cambridge.redhat.com>
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071134.52962.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 18:40, David Howells wrote:

> +Older and less complex CPUs will perform memory accesses in exactly the order
> +specified, so if one is given the following piece of code:
> +
> +	a = *A;
> +	*B = b;
> +	c = *C;
> +	d = *D;
> +	*E = e;
> +
> +It can be guaranteed that it will complete the memory access for each
> +instruction before moving on to the next line, leading to a definite sequence
> +of operations on the bus:

Actually gcc is free to reorder it 
(often it will not when it cannot prove that they don't alias, but sometimes
it can)

> +
> +     Consider, for example, an ethernet chipset such as the AMD PCnet32. It
> +     presents to the CPU an "address register" and a bunch of "data registers".
> +     The way it's accessed is to write the index of the internal register you
> +     want to access to the address register, and then read or write the
> +     appropriate data register to access the chip's internal register:
> +
> +	*ADR = ctl_reg_3;
> +	reg = *DATA;

You're not supposed to do it this way anyways. The official way to access
MMIO space is using read/write[bwlq]

Haven't read all of it sorry, but thanks for the work of documenting 
it.

-Andi

