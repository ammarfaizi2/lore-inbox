Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUEFOuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUEFOuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUEFOuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:50:13 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:45316 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261900AbUEFOuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:50:10 -0400
Date: Thu, 6 May 2004 15:50:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_ioctl export consolidation
Message-ID: <20040506155008.A17635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <s09a2e2c.054@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s09a2e2c.054@emea1-mh.id2.novell.com>; from JBeulich@novell.com on Thu, May 06, 2004 at 01:23:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 01:23:24PM +0200, Jan Beulich wrote:
> Since we noted that sys_ioctl is not currently being exported for ia64
> to be used in the 32-bit emulation routines I'd like to suggest the
> following patch, which, instead of making this available in another
> individual architecture, exports the symbol whenever CONFIG_COMPAT is
> defined (legal users should be a subset of
> [un]register_ioctl32_conversion users, which is scoped by the same
> config option).

Should ioctl32 handlers in drivers really call sys_ioctl?  Calling sys_ioctl
makes sense for ioctls that are supported by a broad range of drivers, but
in that case the ioctl32 translation should be in the core compat code.

Drivers using register_ioctl32_conversion should rather call their own
ioctl handlers directly if you ask me.

Do you have a list of drivers currently needing sys_ioctl?

