Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWHAS7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWHAS7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWHAS7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:59:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751795AbWHAS7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:59:52 -0400
Message-ID: <44CFA5A8.50105@redhat.com>
Date: Tue, 01 Aug 2006 15:04:08 -0400
From: Amit Gud <agud@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com, deweerdt@free.fr
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
References: <44CF69F0.6040801@redhat.com> <Pine.LNX.4.64.0608011155040.12077@turbotaz.ourhouse> <Pine.LNX.4.64.0608011213190.12077@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0608011213190.12077@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> On Tue, 1 Aug 2006, Chase Venters wrote:
> Btw, wanted to add some comments on the specific approach:
> 
> 1. A ring hard-coded to 32 elements is IMO unuseable. While it may not 
> be a real limit for what use case you have in mind, if it's in the 
> kernel sooner or later someone else is going to use it and get bitten. 
> Imagine if they wrote in 33 entries, and the first one was some critical 
> security setting that ended up getting silently ignored...
> 
> 2. On the other hand, allowing it to grow unbounded is equally 
> unacceptable without a mechanism to list and clear the current "pending" 
> sysctl values. Unfortunately, at this point, you're starting to violate 
> "KISS".
> 

You figured it right, theres no "correct" number of elements that I 
could adhere to.

> Are the modules you refer to inserted during init at all? Because it 
> seems like it would be a lot more appropriate to just move sysctl until 
> after loading the modules, or perhaps running it again once they are 
> loaded.
> 

I have a case where sunrpc module gets inserted and 
sunrpc.tcp_slot_table_entries parameter is to be set _before_ nfs module 
is inserted. I agree that for this particular case user-space works 
(either udev rule, or modprobe.conf or sysctl after modprobe in 
initscripts), but am on a lookout for a more generic way for handling 
such cases - be it user-space or otherwise.


AG
-- 
May the source be with you.
http://www.cis.ksu.edu/~gud

