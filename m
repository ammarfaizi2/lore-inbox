Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUH2Mnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUH2Mnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUH2Mnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:43:33 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:22606 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267792AbUH2Mnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:43:31 -0400
Message-ID: <4131CF4A.50205@yahoo.com.au>
Date: Sun, 29 Aug 2004 22:42:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Joachim Bremer <joachim.bremer@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: <no subject>
References: <1248337375@web.de>
In-Reply-To: <1248337375@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Bremer wrote:
> As mentioned before I got even with Nicks patch some errors. Looking
> closer at the source there is is a second "goto page_ok" a few lines
> down the label "page_not_up_to_date". Inserting the same calculating
> code used before the label "readpage_error" fixes the errors on my machine.
> These for instance where failure to do reiserfsck (bread complains on last block
> of device) and compiling the linux-tree (file truncated).
> 
> The leads to the same calculation 3 times...
> 

Surely not - there is only 1 way to get to page_not_up_to_date,
and through that path you have already done that calculation and
none of the variables involved have been changed.

I think. Put a printk before your goto out, and if it triggers
then I am wrong.

What errors were you seeing with my patch? (If you applied my patch
to an -mm kernel without first backing out the others then it will
break).
