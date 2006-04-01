Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWDAC5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWDAC5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWDAC5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:57:03 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:38491 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751483AbWDAC5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:57:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4kpDbPT5/J2nmNX+Q1IznNpCLKlkGheCVnkEAwXqp8Wm7gm55Hr5SkFhlWzB1ansO/utxl9cKbIgDzXC53egga1hR+ysk9xcavmL2KnWiGylcnUqOm6HMhhP5yFjb7bg+WoKFizeqwQuh/uyttjjOozXgcdSaivK6+H07xKjH5M=  ;
Message-ID: <442DEBF7.1090806@yahoo.com.au>
Date: Sat, 01 Apr 2006 12:56:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@SGI.com>
CC: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com> <442C7B51.1060203@yahoo.com.au> <Pine.LNX.4.64.0603301921550.3145@schroedinger.engr.sgi.com> <442CAC11.4070803@yahoo.com.au> <Pine.LNX.4.64.0603310939570.6628@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603310939570.6628@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 31 Mar 2006, Nick Piggin wrote:

>>You acknowledge that you have to fix ia64 to match current semantics
>>first, right?
> 
> 
> Right. I believe I have done so by making both smb_mb_* full barriers.

All bitop and atomic test_and_set, inc_return, etc etc (ie. everything
that modifies the operand and returns something) needs to be a full
barrier before and after too.

>>Now people seem to be worried about the performance impact that will
>>have, so I simply suggest that adding two or three new macros for the
>>important cases to give you a 90% solution.
> 
> 
> We could transition some key locations of core code to use _mode bitops
> if there are performance problems.
> 
> 
>>I think Documentation/atomic_ops.txt isn't bad. smp_mb__* really
>>is a smp_mb, which can be optimised sometimes.
> 
> 
> Ok. Then we are on the same page and the solution I presented may be 
> acceptable. I have a new rev here that changes the naming a bit but I 
> think we are okay right?

Not sure, to be honest. I think it is probably something which needs
input from all the other arch people, and Linus, if you intend to use
it to introduce new types of barriers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
