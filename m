Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVJLD2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJLD2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 23:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJLD17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 23:27:59 -0400
Received: from smtpout.mac.com ([17.250.248.46]:47308 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932395AbVJLD17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 23:27:59 -0400
In-Reply-To: <20051012023950.5261.qmail@science.horizon.com>
References: <20051012023950.5261.qmail@science.horizon.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <678DF2CB-3842-4801-9A86-787957CB3DDF@mac.com>
Cc: cfriesen@nortel.com, dev@sw.ru, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Tue, 11 Oct 2005 23:27:33 -0400
To: linux@horizon.com
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 11, 2005, at 22:39:50, linux@horizon.com wrote:
>> This may work on some processors, but on others the read of  
>> "progress" in XXX, or the write in YYY may require arch-specific  
>> code to force the update out to other cpus.
>>
>> Alternately, explicitly atomic operations should suffice, but a  
>> simple increment is probably not enough for portable code.
>
> Er.. you mean, the pre-incremented value could be cached  
> *indefinitely* by XXX?  That seems odd...
>
> I can see an arch hook (memory barrier sort of thuing) to push it  
> out a bit faster, but are there architecures on which noticing the  
> increment could be delayed indefinitely?
>
> In particular, that same hook would already be used by the spin  
> lock release sequence (to ensure that someone else notices the lock  
> is now available), and unless it's address-specific, it would do  
> for the "progress" counter as well.

Umm, IIRC, some architectures (don't remember which ones, but I'd  
guess it's the big 512-way boxen) have cache-line-and-memory models  
such that a cacheline may remain out-of-date indefinitely unless the  
CPU with the update runs a "cache-line flush" instruction or the CPU  
who wants an update requests one with an exclusive cacheline lock or  
similar.  On such a system, the only way to ensure safe distribution  
of data between CPUs is to make sure it's in the same cacheline as  
the spinlock (and document that fact) or use special instructions to  
verify coherency.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


