Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVDFAYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVDFAYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVDFAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:24:12 -0400
Received: from palrel11.hp.com ([156.153.255.246]:59278 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262043AbVDFAYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:24:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16979.11287.36091.610287@napali.hpl.hp.com>
Date: Tue, 5 Apr 2005 17:23:51 -0700
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: davidm@hpl.hp.com, Andi Kleen <ak@muc.de>,
       Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <Pine.LNX.4.58.0504051706110.12179@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<Pine.LNX.4.58.0504051706110.12179@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 5 Apr 2005 17:15:53 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:

  Christoph> On Thu, 24 Mar 2005, David Mosberger wrote:
  >> That's definitely the case.  See my earlier post on this topic:

  >> http://www.gelato.unsw.edu.au/linux-ia64/0409/11012.html

  >> Unfortunately, nobody reported any results for larger machines
  >> and/or more interesting workloads, so the patch is in limbo at
  >> this time.  Clearly, if the CPU that's clearing the page is
  >> likely to use that same page soon after, it'd be useful to use
  >> temporal stores.

  Christoph> Here are some numbers using lmbench of temporal writes
  Christoph> vs. non temporal writes on ia64 (8p machine but lmbench
  Christoph> run only for one load). There seems to be some benefit
  Christoph> for fork/exec but overall this does not seem to be a
  Christoph> clear win. I suspect that the distinction between
  Christoph> temporal vs. nontemporal writes is be more beneficial on
  Christoph> machines with smaller pagesizes since the likelyhood that
  Christoph> most cachelines of a page are used soon is increased and
  Christoph> therefore hot zeroing is more beneficial.

What LMbench test other than fork/exec would you have expected to be
affected by this?  LMbench is not a good benchmark for this (remember:
it's a _micro_ benchmark).

	--david
