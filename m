Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVLLHFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVLLHFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVLLHFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:05:30 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:52372 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbVLLHFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:05:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H9O4qMc1wgHkAlJzaD7e/7l0fjQvKekwV2pqunNx+60tLsjPbyK0NjA0cVxk1W7F/NILqci57Ooc8Y6QWBnUhfsV7Fh/dN3iQRpQsx+YFJWuTT/f0fqHxYAkVw/3pmCk39HWnSxm//+RikWro7/D5TXsfwUOF0cQlfyDonFMp04=  ;
Message-ID: <439D2135.4050804@yahoo.com.au>
Date: Mon, 12 Dec 2005 18:05:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com> <439CF2A2.60105@yahoo.com.au> <20051212035631.GX11190@wotan.suse.de> <439CF93D.5090207@yahoo.com.au> <20051212042142.GZ11190@wotan.suse.de> <439CFC67.4030107@yahoo.com.au> <20051212045146.GA11190@wotan.suse.de>
In-Reply-To: <20051212045146.GA11190@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>Then you can't use __local_xxx, and so many architectures will use
>>atomic instructions (the ones who don't are the ones with tripled
>>cacheline footprint of this structure).
> 
> 
> They are wrong then. atomic instructions is the wrong implementation
> and they would be better off with asm-generic. 
> 

Yes I mean atomic and per-cpu. Same as asm-generic.

> If anything they should use per_cpu counters for interrupts and 
> use seq locks.

How would seqlocks help?

> Or just turn off the interrupts for a short time
> in the low level code.
> 

This is exactly what mod_page_state does, which is what my patches
eliminate. For a small but significant performance improvement.

> 
>>Sure i386 and x86-64 are happy, but this would probably slow down
>>most other architectures.
> 
> 
> I think it is better to fix the other architectures then - if they
> are really using a full scale bus lock for this they're just wrong.
> 
> I don't think it is a good idea to do a large change in generic
> code just for dumb low level code.
> 

It is not a large change at all, just some shuffling of mod_page_state
and friends to go under pre-existing interrupts-off sections.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
