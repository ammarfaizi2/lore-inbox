Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbUKKBUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUKKBUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKKBUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:20:50 -0500
Received: from canuck.infradead.org ([205.233.218.70]:11026 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262074AbUKKBUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:20:44 -0500
Subject: Re: [PATCH] VM routine fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dhowells <dhowells@redhat.com>, hch@infradead.org, torvalds@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
In-Reply-To: <20041110110145.3751ae17.akpm@osdl.org>
References: <20041109140122.GA5388@infradead.org>
	 <20041109125539.GA4867@infradead.org>
	 <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
	 <15068.1100008386@redhat.com> <4530.1100093877@redhat.com>
	 <20041110110145.3751ae17.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 01:17:13 +0000
Message-Id: <1100135833.4631.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 11:01 -0800, Andrew Morton wrote:
> Why _does_ !CONFIG_MMU futz around with page counts in such weird ways
> anyway?  Why does it have requirements for higher-order pages which differ
> from !CONFIG_MMU?

Because in the absence of an MMU, an mmap of a large region (like an
executable) has to be satisfied by a large enough allocation followed by
a read.

> If someone could explain the reasoning behind the current code, and the FRV
> enhancements then perhaps we could work something out.

I think these parts aren't FRV-specific; they're the fixes required to
do proper shared readable mmap with !CONFIG_MMU. That was a prerequisite
for the ELF-FDPIC executable format, which allows real shared libraries
on uClinux.

-- 
dwmw2

