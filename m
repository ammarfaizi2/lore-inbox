Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUEFPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUEFPtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUEFPtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:49:41 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62587
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S262794AbUEFPt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:49:26 -0400
Message-Id: <s09a6c94.074@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 06 May 2004 17:49:30 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sys_ioctl export consolidation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's certainly another possibility, putting under question why for
certain architectures sys_ioctl gets exported (by inspection I can see a
valid reason only for sparc64).

Anyway, I don't have a list of drivers ready, I just ran into the issue
because a driver I had to port over from 2.4 worked on all intended
architectures but ia64, and I initially intended to go the route you
point out until I found that most 64-bit architectures with 32-bit
emulation layers actually export the symbol for appearantly this very
purpose.

>>> Christoph Hellwig <hch@infradead.org> 06.05.04 16:50:08 >>>
On Thu, May 06, 2004 at 01:23:24PM +0200, Jan Beulich wrote:
> Since we noted that sys_ioctl is not currently being exported for
ia64
> to be used in the 32-bit emulation routines I'd like to suggest the
> following patch, which, instead of making this available in another
> individual architecture, exports the symbol whenever CONFIG_COMPAT
is
> defined (legal users should be a subset of
> [un]register_ioctl32_conversion users, which is scoped by the same
> config option).

Should ioctl32 handlers in drivers really call sys_ioctl?  Calling
sys_ioctl
makes sense for ioctls that are supported by a broad range of drivers,
but
in that case the ioctl32 translation should be in the core compat
code.

Drivers using register_ioctl32_conversion should rather call their own
ioctl handlers directly if you ask me.

Do you have a list of drivers currently needing sys_ioctl?

