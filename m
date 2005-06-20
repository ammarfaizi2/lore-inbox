Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFTN5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFTN5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFTN5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:57:01 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:28137 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261242AbVFTN46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:56:58 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: __alloc_pages ()
From: Alexander Nyberg <alexn@telia.com>
To: "Parveen  Verma, Noida" <Parveenv@noida.hcltech.com>
Cc: linux.guy@rediffmail.com,
       "Shilpi Jaiswal, Noida" <shilpij@noida.hcltech.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <8A6EB6A72A5C774C8814DDC1501FC90E97C07B@exch-01.noida.hcltech.com>
References: <8A6EB6A72A5C774C8814DDC1501FC90E97C07B@exch-01.noida.hcltech.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 20 Jun 2005 15:52:07 +0200
Message-Id: <1119275527.1037.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mån 2005-06-20 klockan 17:23 +0530 skrev Parveen Verma, Noida:
> Hi,
> 
> I have found that while allocating (mostly it is done) the pages in
> __alloc_pages(), after successfully allocating the page the
> zone_statistics() function is called.
> 
> static void zone_statistics(struct zonelist *zonelist, struct zone *z)
> {
> #ifdef CONFIG_NUMA
> .....
> #endif
> }
> The whole body of this function is enclosed b/w #ifdef ... #endif.
> This function is called each time and does nothing if we don't have a NUMA
> machine.
> Can we put the call for this b/w #ifdef ... #endif?
> Although the gcc -O3 option does not generate a function call if the
> function body is nil.

I'd say gcc should optimize this out as is already, but now that it
doesn't, if you just make zone_statistics() inline the call will go away
with -O2

