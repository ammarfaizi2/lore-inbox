Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269643AbUJTKxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269643AbUJTKxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUJTKwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:52:30 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:17543 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S269931AbUJTKmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:42:49 -0400
Subject: Re: iproute2 and 2.6.9 kernel headers (was Re: [ANNOUNCE] iproute2
	2.6.9-041019)
From: David Woodhouse <dwmw2@infradead.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
In-Reply-To: <20041020094123.GF19899@sunbeam.de.gnumonks.org>
References: <41758014.4080502@osdl.org>
	 <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
	 <20041020070017.GA19899@sunbeam.de.gnumonks.org>
	 <20041020094123.GF19899@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1098268885.3872.81.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 20 Oct 2004 11:41:25 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 11:41 +0200, Harald Welte wrote:
> On Wed, Oct 20, 2004 at 09:00:17AM +0200, Harald Welte wrote:
> > I'll take care of this. sorry fort he inconvenience.
> 
> I should actually read mails befor replying ;)  I thought the bug was in
> lnstat - but apparently it wasn't.
> 
> The include bug seems non-trivial to fix. (how do I hate kernel include
> from userspace issues):
> 
> apparently __KERNEL_STRICT_NAMES is definde somewhere (glibc?) which
> prevents __le16, __le64 and others from being defined in linux/types.h.
> 
> Just reietting it like this doesn't help much:

No, it wouldn't.

The time has come to fix it properly instead. Anything which these tools
actually need from the kernel headers should be moved into a separate
header file (still in the kernel source) which is usable from _both_
kernel and userspace. It should use standard types (like uint16_t etc)
instead of kernel-private types, and shouldn't have any #if{n,}def
__KERNEL__ in it. Ideally, it would be in a different directory too --
but we can worry about that later.

-- 
dwmw2


