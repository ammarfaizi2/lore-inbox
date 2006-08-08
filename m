Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWHHQt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWHHQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHHQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:49:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32072 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964991AbWHHQt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:49:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShELPypiFxK6eXLt9KR5Pns0LD4ZE2UmADjrJdNQBV85biv/MJLj8M+vPFz7gTHDYzKYKnz0fNGnd3MbbYNPks4cNVn3jSkOhc8PZqMEbNTql9FrWhty6W0dzumH20cuBfFXO4dtRhtBe0jwBx3lXX28UfX0+qwuUllPUKeRnFc=
Message-ID: <a36005b50608080949y13a8eb2m5d9a2d993ab9fae8@mail.gmail.com>
Date: Tue, 8 Aug 2006 09:49:54 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] NUMA futex hashing
Cc: "Eric Dumazet" <dada1@cosmosbay.com>, "Andi Kleen" <ak@suse.de>,
       "Ravikiran G Thirumalai" <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "pravin b shelar" <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D8BA39.5020405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808070708.GA3931@localhost.localdomain>
	 <200608081429.44497.dada1@cosmosbay.com>
	 <200608081447.42587.ak@suse.de>
	 <200608081457.11430.dada1@cosmosbay.com>
	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
	 <44D8A9BE.3050607@yahoo.com.au>
	 <a36005b50608080836u3e58ab85l61bb50b2bac5a0e3@mail.gmail.com>
	 <44D8BA39.5020405@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> I thought mremap (no, that's already kind of messed up); or
> even just getting consistency in failures (eg. so you don't have
> the situation that a futex op can succeed on a previously
> unmapped region).
>
> If you're not worried about the latter, then it might work...

I'm not the least bit worried about this.  It's 100% an application's
fault.  You cannot touch an address space if it's used, e.g., for
mutexes.


> I didn't initially click that the private futex API operates
> purely on tokens rather than virtual memory...

I haven't looked at the code in some time but I thought this got
clarified in the comments.  For waiting on private mutexes we need
nothing but the address value itself.  There is the FUTEX_WAKE_OP
operation which will also write to memory but this is only the waker
side and if the memory mapping is gone, just flag an error.  It's
another program error which shouldn't in any way slow down normal
operations.
