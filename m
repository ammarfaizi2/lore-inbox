Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUCZUZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbUCZUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:25:12 -0500
Received: from palrel12.hp.com ([156.153.255.237]:52922 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264129AbUCZUZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:25:07 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.37279.839961.375027@napali.hpl.hp.com>
Date: Fri, 26 Mar 2004 12:25:03 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, davej@redhat.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326104904.59f7a156.akpm@osdl.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
	<20040326104904.59f7a156.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Mar 2004 10:49:04 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> But the start address which is fed into prefetch_range() may
  Andrew> not be cacheline-aligned.  So if appropriately abused, a
  Andrew> prefetch_range() could wander off the end of the user's
  Andrew> buffer and into a new page.

  Andrew> I think this gets it right, but I probably screwed something
  Andrew> up.

Please, let's not make this more complicated than it is.  The
cacheline alignment doesn't matter at all.  Provided prefetch_range()
is given a range of guaranteed to be valid memory, then it will be
fine.  It never touches anything outside the specified range.

	--david
