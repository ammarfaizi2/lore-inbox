Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVCXSkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVCXSkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVCXSiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:38:23 -0500
Received: from palrel13.hp.com ([156.153.255.238]:4024 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262651AbVCXSel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:34:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16963.2075.713737.485070@napali.hpl.hp.com>
Date: Thu, 24 Mar 2005 10:34:03 -0800
To: Andi Kleen <ak@muc.de>
Cc: Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
In-Reply-To: <20050318192808.GB38053@muc.de>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 18 Mar 2005 20:28:08 +0100, Andi Kleen <ak@muc.de> said:

  >> stores in general for clearing pages? I checked and Itanium has
  >> always used non-temporal stores. So there will be no benefit for
  >> us from this

  Andi> That is weird. I would actually try to switch to temporal
  Andi> stores, maybe it will improve some benchmarks.

That's definitely the case.  See my earlier post on this topic:

  http://www.gelato.unsw.edu.au/linux-ia64/0409/11012.html

Unfortunately, nobody reported any results for larger machines and/or
more interesting workloads, so the patch is in limbo at this time.
Clearly, if the CPU that's clearing the page is likely to use that
same page soon after, it'd be useful to use temporal stores.

	--david
