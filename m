Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937121AbWLFTAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937121AbWLFTAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937136AbWLFTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:00:36 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2871 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937121AbWLFTAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:00:35 -0500
Date: Wed, 6 Dec 2006 19:00:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206190025.GC9959@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 10:56:14AM -0800, Christoph Lameter wrote:
> I'd really appreciate a cmpxchg that is generically available for 
> all arches. It will allow lockless implementation for various performance 
> criticial portions of the kernel.

Let's recap on cmpxchg.

For CPUs with no atomic operation other than SWP, it is not lockless.
For CPUs with load locked + store conditional, it is expensive.

I've shown in the past that a generic implementation based around ll/sc
can be cheaply implemented using cmpxchg.  The reverse is *not* true.

If you want an operation for performance critical portions of the
kernel, please allow architecture maintainers the freedom to use their
best performance enhancements.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
