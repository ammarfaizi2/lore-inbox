Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbVCXSpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbVCXSpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVCXSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:45:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:12737 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263160AbVCXSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:43:02 -0500
Date: Thu, 24 Mar 2005 10:41:06 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: davidm@hpl.hp.com
cc: Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <16963.2075.713737.485070@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, David Mosberger wrote:

> That's definitely the case.  See my earlier post on this topic:
>
>   http://www.gelato.unsw.edu.au/linux-ia64/0409/11012.html
>
> Unfortunately, nobody reported any results for larger machines and/or
> more interesting workloads, so the patch is in limbo at this time.
> Clearly, if the CPU that's clearing the page is likely to use that
> same page soon after, it'd be useful to use temporal stores.


So it would be useful to have

clear_page 	-> Temporal. Only zaps one page

	and

clear_pages	-> Zaps arbitrary order of page non-temporal


Rework the clear_pages patch to do just that? Maybe rename clear_pages
clear_pages_nt?

prep_zero_page would use a temporal clear for an order 0 page but a
nontemporal clear for higher order pages.
