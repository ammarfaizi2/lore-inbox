Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVG0XCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVG0XCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVG0W7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:59:51 -0400
Received: from ozlabs.org ([203.10.76.45]:23513 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261225AbVG0W6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:58:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
Date: Wed, 27 Jul 2005 18:56:55 -0400
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Porter <mporter@kernel.crashing.org>, wfarnsworth@mvista.com,
       linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] ppc32: add 440ep support
In-Reply-To: <20050727131857.78a56972.akpm@osdl.org>
References: <11224856623638@foobar.com>
	<20050727131857.78a56972.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > +static u64 dma_mask = 0xffffffffULL;
> 
> I'm sure you're totally uninterested in this, but the above will probably
> generate warnings on (say) ppc64, where u64 is implemented as unsigned
> long.
> 
> I usually chuck a simple `-1' in there and the compiler always gets it
> right, regardless of signedness and size and architecture.

Umm, I think we actually want 2^32-1 not -1, don't we?  In which case
I think Matt's code is what we have to have.

I tried a little test compile with gcc 4.0 with -m64 -Wall and it
didn't generate a warning with the 0xffffffffULL constant.

Paul.
