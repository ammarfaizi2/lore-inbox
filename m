Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUFASCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUFASCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUFASCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 14:02:11 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:10513 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S265130AbUFASCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 14:02:00 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all? (what the user feels)
Date: Tue, 1 Jun 2004 11:01:55 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEGNMFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <40BCBF2E.7030802@minimum.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 10:39:46 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 10:39:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  From what I've read previously in this thread, it seems to me that the
> only major problem with swapping that not all users want file system
> cache to swap out actual applications (thus making that somewhat aged
> mozilla window abit laggy).
>
> Maybe we could just have a "Allow file system cache to swap out
> applications checkbox somewhere"?
>
> Or, Am I missing something?

	In practice, that would make no difference at all. Once physical memory is
full (and it pretty much will always be so), every memory request (whether
due to the file system cache or application usage) will require discarding
some page or other. So even if all memory requests due to file system cache
usage were prohibited from forcing out application pages, you're launching
enough other application that need pages that application pages will still
be evicted.

	Now, if you make the rule "don't ever swap out application pages", what
exactly is the swap going to do? Swap is for dirty pages. Dirty file pages
get written back to their ultimate home, not swap.

	DS


