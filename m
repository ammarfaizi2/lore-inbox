Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWFJAU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWFJAU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWFJAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932606AbWFJAU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:20:27 -0400
Date: Fri, 9 Jun 2006 17:23:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       creese@caviumnetworks.com, apw@shadowen.org
Subject: Re: [PATCH] mem_map is part of the FLATMEM model
Message-Id: <20060609172306.0ce6bf86.akpm@osdl.org>
In-Reply-To: <20060609134850.GA20794@shadowen.org>
References: <447DCBAD.8070307@shadowen.org>
	<20060609134850.GA20794@shadowen.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> mem_map is part of the FLATMEM model
> 
> It seems that the definition and declaration of mem_map are
> inconsistent meaning we get usless undirected link failures about
> mem_map when its being used when it shouldn't be.
> 
> Reviewing mem_map, its actually only valid and initialised when
> CONFIG_FLATMEM is defined.  Indeed in all essence it is part
> of that memory model used out of FLATMEM's __pfn_to_page etc.
> mem_map (and max_mapnr) should only be defined and declared when
> the FLATMEM memory model is selected.

sparc64 allmodconfig:

arch/sparc64/mm/init.c: In function `paging_init':
arch/sparc64/mm/init.c:1339: error: `max_mapnr' undeclared (first use in this function)
arch/sparc64/mm/init.c:1339: error: (Each undeclared identifier is reported only once

