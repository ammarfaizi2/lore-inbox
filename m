Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbUJYW0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUJYW0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUJYWYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:24:09 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:50167 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261946AbUJYWEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:04:35 -0400
Message-ID: <417D786F.4020101@acm.org>
Date: Mon, 25 Oct 2004 17:04:31 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels II
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl> <20041025201758.GG9142@wotan.suse.de> <20041025204144.GA27518@wotan.suse.de> <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Mon, 25 Oct 2004, Andi Kleen wrote:
>
>  
>
>>So it's impossible to check the old value. The original code is the only
>>way to do this (if it's even needed, Intel also doesn't say anything
>>about this bit being a flip-flop). Only possible change would be to 
>>write an alternative index.
>>    
>>
>
> You can't read the old value, but you can have a shadow variable written
>every time the real index is written.  Since NMIs are not preemptible and
>this is a simple producer-consumer access, no mutex around accesses to the
>variable is needed.
>
>  Maciej
>  
>
If you look at my patch, it does create a shadow index.

And you need a mutex for SMP systems.  If one processor is handling an 
NMI, another processor may still be accessing the device.

The complexity comes because the claiming of the lock, the CPU that owns 
the lock, and the index has to be atomic because the NMI handler has to 
know all these things when the lock is claimed.

-Corey
