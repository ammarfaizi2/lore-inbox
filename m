Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbULBWRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbULBWRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbULBWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:17:40 -0500
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:37071 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S261788AbULBWRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:17:22 -0500
Message-ID: <41AF9469.1060301@bigpond.net.au>
Date: Fri, 03 Dec 2004 09:17:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <E1CZiZZ-0005ew-00@calista.eckenfels.6bone.ka-ip.net> <41AEA3F0.9080100@bigpond.net.au> <41AEFCCC.10907@dbservice.com>
In-Reply-To: <41AEFCCC.10907@dbservice.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:
> Peter Williams wrote:
> 
>> Design by contract isn't really an agreement between the caller and 
>> the callee (which may not even exist when the contract is created).  
>> It's more of a (one way) promise by the callee that if the interface 
>> is used as described in the contract that it will correctly perform 
>> the advertised operation (where the advertised operation generally 
>> includes descriptions of possible failures and how they will be 
>> signalled).  Most C APIs meet these criteria even though their pre and 
>> post conditions are expressed less formally than an Eiffel interface.
> 
> 
> Design by Contract, as seen in the Eiffel language, is not a one way 
> promise, it's a contract between the caller and callee. Both sides have
> to fullfil their part of the contract, the caller has to make sure that
> the input are valid, and (only) given that, the callee can/has to make
> sure that the caller gets the right output.
> 
> BTW, Bertrand Meyer is one of my professors, I should know the Eiffel 
> language... :)

Yes, but I still think it's essentially a one way thing.  The writer of 
the callee doesn't have to consult with the writer of the caller to 
negotiate the contract (although that option isn't ruled out either) so 
it's essentially a unilateral promise on  the part of the callee.  This 
would especially be the case when writing library interfaces as it's 
impossible for the writer of the callee to negotiate with all the 
(potential) writers of callers to agree on an interface.

> 
>> I agree but think it's important to realize that it's a unilateral 
>> promise on the part of the callee (rather than agreement between the 
>> callee and the caller) which is in accord with Linus's view of the ABI.
> 
> 
> Whenever you have two sides/parties, you have to agree on _something_, 
> otherwise you can't communicate, if you speak to someone, you have to 
> choose a language in which to speak, that's the first agreement.
> In this situation you have two sides, the kernel and the userspace. Your 
> first agreement is the syscall number, and then the arguments, the type 
> and format of the arguments, etc. Both sides have to agree on those things.

Not really.  In the final analysis, userspace has to accept what the 
kernel provides.  It's not really a conversation it's more like a 
billboard on which the kernel describes an interface and makes promises 
about how it will operate if used according to the specification (or 
contract).  If the caller fails to use the interface within the 
constraints of the specification (or contract) then the result is 
indeterminate and the callee can do whatever it likes including failing 
silently or even crashing (although that wouldn't be a good idea for a 
kernel interface).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
