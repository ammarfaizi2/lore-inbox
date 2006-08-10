Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWHJJ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWHJJ2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWHJJ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:28:13 -0400
Received: from [80.71.248.82] ([80.71.248.82]:35280 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1751463AbWHJJ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:28:12 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: ClusterFS Inc.
Date: Thu, 10 Aug 2006 13:29:56 +0400
In-Reply-To: <20060809233940.50162afb.akpm@osdl.org> (Andrew Morton's message of "Wed, 9 Aug 2006 23:39:40 -0700")
Message-ID: <m37j1hlyzv.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 >> From a quick scan:

 AM> - The code is very poorly commented.  I'd want to spend a lot of time
 AM>   reviewing this implementation, but not in its present state.  

what sort of comments are you expecting?

 AM> - Far, far too many inlines

probably, I'll review the code in this regard

 AM> - overly-terse variable naming

same

 AM> - There are several places which appear to be putting block numbers into
 AM>   an `int'.

same

 AM> - Needs kmalloc()->kzalloc() conversion

OK

 AM> - replace all brelse() calls with put_bh().  Because brelse() is
 AM>   old-fashioned, has a weird name and neelessly permits a NULL arg.

 AM>   In fact it would be beter to convert JBD and ext3 to put_bh before
 AM>   copying it all over.

OK

 AM> - The open-coded __clear_bit(BH_New, ...) in ext4_ext_get_blocks is a bit
 AM>   nasty.  We can live with nasty, but are we sure that it isn't buggy??

I believe it isn't buggy -- it applies to non-shared var.
it also showed minor improvement on SMP.

 AM> - It has about 7,000 instances of

 AM> 	if ((lhs = expression)) {

 AM>   whereas the preferred coding style is

 AM> 	lhs = expression;
 AM> 	if (lhs) {

OK

 AM> - The existing comments could benefit from some rework by a native English
 AM>   speaker.

could someone assist here, please?

thanks, Alex
