Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVFUF21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVFUF21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVFUFZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:25:59 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:21149 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S261944AbVFUFYx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:24:53 -0400
Message-ID: <8A6EB6A72A5C774C8814DDC1501FC90EA04152@exch-01.noida.hcltech.com>
From: "Parveen  Verma, Noida" <Parveenv@noida.hcltech.com>
To: Alexander Nyberg <alexn@telia.com>,
       "Parveen Verma, Noida" <Parveenv@noida.hcltech.com>
Cc: linux.guy@rediffmail.com,
       "Shilpi Jaiswal, Noida" <shilpij@noida.hcltech.com>,
       linux-kernel@vger.kernel.org
Subject: RE: __alloc_pages ()
Date: Tue, 21 Jun 2005 10:54:00 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
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
> { #ifdef CONFIG_NUMA .....
> #endif
> }
> The whole body of this function is enclosed b/w #ifdef ... #endif.
> This function is called each time and does nothing if we don't have a 
> NUMA machine.
> Can we put the call for this b/w #ifdef ... #endif?
> Although the gcc -O3 option does not generate a function call if the 
> function body is nil.

I'd say gcc should optimize this out as is already, but now that it doesn't,
if you just make zone_statistics() inline the call will go away with -O2

I checked with gcc 4.0.0 in FC4, the gcc optimizes it without making inline
and with -O1 option too.

Now the main point is how can we incorporate this change in main Linux
kernel.

-- 
Praveen Verma
(Hare Rama Hare Krishna)
