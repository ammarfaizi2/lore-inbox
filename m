Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVAFRit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVAFRit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVAFRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:36:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262929AbVAFRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:34:55 -0500
Subject: Re: [Coverity] Untrusted user data in kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jaharkes@cs.cmu.edu, Andrew Morton <akpm@osdl.org>,
       acme@conectiva.com.br, davem@redhat.com, nathans@sgi.com
In-Reply-To: <20050106091844.GB6961@fi.muni.cz>
References: <1103247211.3071.74.camel@localhost.localdomain>
	 <20050105120423.GA13662@logos.cnet> <20050105161653.GF13455@fi.muni.cz>
	 <20050105140549.GA14622@logos.cnet>  <20050106091844.GB6961@fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105018573.24896.191.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:29:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	The SDLA_CLEAR ioctl (the sdla_clear(dev) function) tries
> to clear exactly 65536 bytes (hardcoded at sdla.c:sdla_clear() line 140).
> So the mem.len should be <= 65536 bytes, and even mem.addr + mem.len
> should be <= 65536 bytes.
> 
> 	So I propose the following patch (maybe the constant 65536 should
> be defined in sdla.h and used both in sdla_xfer() and sdla_clear()):

I'd propose they are set to CAP_SYS_RAWIO for those specific
debugging/firmware load operations. They allow access to that level
potentially anyway. That solves the problem cleanly.

