Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVBYWTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVBYWTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVBYWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:19:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25539 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262779AbVBYWTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:19:16 -0500
Message-ID: <421FA503.6000407@us.ibm.com>
Date: Fri, 25 Feb 2005 14:21:55 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vm: mlock superfluous variable
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net>
In-Reply-To: <20050225171122.GE28536@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Darren Hart (dvhltc@us.ibm.com) wrote:
> 
>>The were a couple long standing (since at least 2.4.21) superfluous 
>>variables and two unnecessary assignments in do_mlock().  The intent of 
>>the resulting code is also more obvious.
>>
>>Tested on a 4 way x86 box running a simple mlock test program.  No 
>>problems detected.
> 
> 
> Did you test with multiple page ranges, and locking subsets of vmas?
> Seems that splitting could cause a problem since you now sample vm_end
> before and after fixup, where the vma could be changed in the middle.

Thanks for catching that Chris.  Both the tmp variable and the next 
variable are indeed needed since mlock_fixup could modify both.  Please 
disregard this patch.

--Darren
