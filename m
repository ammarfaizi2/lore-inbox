Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUCXTJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUCXTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:09:06 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:28054 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263057AbUCXTJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:09:04 -0500
Message-ID: <4061DB55.8070600@BitWagon.com>
Date: Wed, 24 Mar 2004 11:02:45 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <20040323231256.GP4677@tpkurt.garloff.de>	<20040323154937.1f0dc500.akpm@osdl.org>	<20040324002149.GT4677@tpkurt.garloff.de>	<16480.55450.730214.175997@napali.hpl.hp.com>	<4060E24C.9000507@redhat.com>	<16480.59229.808025.231875@napali.hpl.hp.com>	<20040324070020.GI31589@devserv.devel.redhat.com>	<16481.13780.673796.20976@napali.hpl.hp.com>	<20040324072840.GK31589@devserv.devel.redhat.com>	<16481.15493.591464.867776@napali.hpl.hp.com>	<4061B764.5070008@BitWagon.com> <16481.49534.124281.434663@napali.hpl.hp.com>
In-Reply-To: <16481.49534.124281.434663@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only one mprotect() call is needed to make the entire stack
> executable.

mprotect() only works on the portion that is currently allocated.
If the stack grows, then another call is needed.  Tracking the high-
water mark is an expense.  Forcing the allocation of the maximum
extent for the stack of the current thread, even to the same copy-
on-write all-zero page, can cause memory overcommit problems.

-- 
John Reiser, jreiser@BitWagon.com

