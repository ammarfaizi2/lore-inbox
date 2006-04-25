Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWDYLSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWDYLSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWDYLSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:18:44 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:34909 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751493AbWDYLSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:18:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=19nGkdN1KEOlLNEBSmV/K3wFG1rU+SKj5n+f4dpPhC29sV582+dXpi++ReDeqhiK862I294pKOP1i03bVd3X8NCyOoQFRFZhEJEfdsRQWls+lyUWLOpCABTTT6vkUy2cco/OcMuFoEDbNMa/Uj9yC2zuvdrrYbityV7H+7onPFg=  ;
Message-ID: <444DF5B4.6030004@yahoo.com.au>
Date: Tue, 25 Apr 2006 20:11:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com> <20060424200657.0af43d6a.akpm@osdl.org>
In-Reply-To: <20060424200657.0af43d6a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Daniel Walker <dwalker@mvista.com> wrote:
> 
>> +	if (likeliness->type & LIKELY_UNSEEN) {
>> +		if (atomic_dec_and_test(&likely_lock)) {
>> +			if (likeliness->type & LIKELY_UNSEEN) {
>> +				likeliness->type &= (~LIKELY_UNSEEN);
>> +				likeliness->next = likeliness_head;
>> +				likeliness_head = likeliness;
>> +			}
>> +		}
>> +		atomic_inc(&likely_lock);
> 
> 
> hm, good enough I guess.  It does need a comment explaining why we
> don't just do spin_lock().

I guess it is so it can be used in NMIs and interrupts without turning
interrupts off (so is somewhat lightweight).

But please Daniel, just use spinlocks and trylock. This is buggy because
it doesn't get the required release consistency correct.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
