Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267272AbUHOXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUHOXxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267276AbUHOXxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:53:16 -0400
Received: from zero.aec.at ([193.170.194.10]:41477 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267272AbUHOXxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:53:14 -0400
To: Christoph Lameter <clameter@sgi.com>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing 
 pte locks?
References: <2ttIr-2e4-17@gated-at.bofh.it> <2tzE4-6sw-25@gated-at.bofh.it>
	<2tCiw-8pK-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 16 Aug 2004 01:53:09 +0200
In-Reply-To: <2tCiw-8pK-1@gated-at.bofh.it> (Christoph Lameter's message of
 "Mon, 16 Aug 2004 01:10:04 +0200")
Message-ID: <m31xi8dkm2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

> On Sun, 15 Aug 2004, David S. Miller wrote:
>
>>
>> Is the read lock in the VMA semaphore enough to let you do
>> the pgd/pmd walking without the page_table_lock?
>> I think it is, but just checking.
>
> That would be great.... May I change the page_table lock to
> be a read write spinlock instead?

That's probably not a good idea. r/w locks are extremly slow on 
some architectures. Including ia64.

Just profile cat /proc/net/tcp on a machine with a lot of memory
and you'll notice.

-Andi

