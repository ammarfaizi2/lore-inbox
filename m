Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVDDBk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVDDBk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVDDBk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:40:57 -0400
Received: from main.gmane.org ([80.91.229.2]:14535 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261967AbVDDBkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:40:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Sun, 03 Apr 2005 20:40:12 -0500
Message-ID: <d2q5ql$9j3$1@sea.gmane.org>
References: <200504012232.j31MWTg03706@unix-os.sc.intel.com> <Pine.LNX.4.58.0504011447580.4774@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-38-238.client.mchsi.com
User-Agent: KNode/0.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> 
> On Fri, 1 Apr 2005, Chen, Kenneth W wrote:
>> 
>> Paul, you definitely want to check this out on your large numa box.  I
>> booted a kernel with this patch on a 32-way numa box and it took a long
>> .... time to produce the cost matrix.
> 
> Is there anything fundamentally wrong with the notion of just initializing
> the cost matrix to something that isn't completely wrong at bootup, and
> just lettign user space fill it in?

Wouldn't getting rescheduled (and thus having another program trash the
cache on you) really mess up the data collection though? I suppose by
spawning off threads, each with a fixed affinity and SCHED_FIFO one could
hang onto the CPU to collect the data. But then it's not (a lot) different
than doing it in-kernel.
 
> Then you couple that with a program that can do so automatically (ie
> move the in-kernel heuristics into user-land), and something that can
> re-load it on demand.

This part seems sensible though :-)

> Voila - you have something potentially expensive that you run once, and
> then you have a matrix that can be edited by the sysadmin later and just
> re-loaded at each boot.. That sounds pretty optimal, especially in the
> sense that it allows the sysadmin to tweak things depending on the use of
> the box is he really wants to.
> 
> Hmm? Or am I just totally on crack?
> 
> Linus


