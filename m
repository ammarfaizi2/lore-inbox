Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUGUU2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUGUU2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266659AbUGUU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:28:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15259 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266657AbUGUU2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:28:18 -0400
Subject: Re: What is the BUG() call in ll_rw_blk.c (2.4.26) for?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Tom Dickson <tdickson@inostor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FEB7B8.2050501@inostor.com>
References: <40FEB7B8.2050501@inostor.com>
Content-Type: text/plain
Message-Id: <1090441662.17490.28.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jul 2004 15:27:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 13:36, Tom Dickson wrote:

> void submit_bh(int rw, struct buffer_head * bh)
> {
> ~        int count = bh->b_size >> 9;
> 
> 
> ~        if (!test_bit(BH_Lock, &bh->b_state))
> ~                BUG();
> 
> Does anyone know what that BUG(); is testing? We're seeing it and want
> to track down what we're doing that is causing it.

You must lock the buffer_head before calling submit_bh.  If the
buffer_head is not locked, you see the BUG.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

