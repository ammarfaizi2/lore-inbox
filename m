Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTLQLnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLQLnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:43:07 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:11653 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264377AbTLQLmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:42:52 -0500
Subject: Re: 2.4.23aa1 ext3 oops
From: David Woodhouse <dwmw2@infradead.org>
To: Jamie Clark <jclark@metaparadigm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3FD7D78A.4080409@metaparadigm.com>
References: <3FA713B9.3040405@metaparadigm.com>
	 <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>
	 <20031206010505.GB14904@dualathlon.random>
	 <3FD7D78A.4080409@metaparadigm.com>
Content-Type: text/plain
Message-Id: <1071661358.13152.26.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7.dwmw2.1) 
Date: Wed, 17 Dec 2003 11:42:38 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 10:33 +0800, Jamie Clark wrote:
> After a quick browse of the assembler output the zeroing would appear to 
> be part of the list_del inline, and edi seems to equate to &sb. 

Seems reasonable. It does look like something's stomped on sb->s_dirty.

> __mark_inode_dirty() does not appear to take sb_lock before adding to 
> the s_dirty list. Could that be the culprit?

I don't think so; it's holding the inode_lock which should be
sufficient. Besides -- in practice all updates to the 4-byte pointer
sb->s_dirty.next are going to be atomic, and there's no reason _ever_
for it to be set to d7ffbc08. It's hard to see how a simple locking
problem is going to cause such a thing.

How repeatable is this? Can you turn on slab poisoning?

-- 
dwmw2


