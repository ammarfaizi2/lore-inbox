Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVGGMeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVGGMeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGGMXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:23:18 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:31671 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261338AbVGGMW0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:22:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8nXklJsZQhYUzkwiCvjLnjS9+O4WsWdazGuYhCmMttLCmGXAL5X0U9gXhg9m/RgHc32bIB2BCmM2zPnjtn4Goqz5908Oq1tXrrw4xz7x83RgN/RJeuBvUZFJMaBrfemwbc2MqI2zxpRXPtjyLTouqNCmou5zPNq/WzRjvSSUJ8=
Message-ID: <c2a3abd10507070522d60a1bc@mail.gmail.com>
Date: Thu, 7 Jul 2005 14:22:25 +0200
From: Gerald Schaefer <gerald.schaefer@gmail.com>
Reply-To: geraldsc@de.ibm.com
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: empty_zero_page
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, cotte@de.ibm.com
In-Reply-To: <20050705.125242.104033031.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050705.125242.104033031.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/05, David S. Miller <davem@davemloft.net> wrote:
> 
> Why does mm/filemap_xip.c make an explicit reference to
> "empty_zero_page"?  That's bogus, and ZERO_PAGE() is how
> generic code should get at this thing.
> 
> In fact, what the mm/filemap_xip.c code wants is the page
> struct, not the address of the page itself, because it
> does a virt_to_page() on empty_zero_page in every such
> reference.
> 
> This causes build failures for XIP support on sparc64.
> 
> When moving mm/filemap_xip.c over to ZERO_PAGE(), we will
> need to determine the virtual address at which the ZERO_PAGE()
> will be mapped.  This shouldn't be difficult to determine,
> and it's incredibly important to get this right, wrt. page
> coloring concerns, particularly on MIPS which does make use
> of the 'vaddr' argument to ZERO_PAGE().

Good point, seems like there is no reason to use empty_zero_page instead
of ZERO_PAGE. Carsten is out of the office this week, but we will get back
to this next week.
