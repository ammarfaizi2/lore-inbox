Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVJKQgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVJKQgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVJKQgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:36:37 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:5153 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1751417AbVJKQgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:36:36 -0400
Message-ID: <434BEA0D.9010802@cosmosbay.com>
Date: Tue, 11 Oct 2005 18:36:29 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only
 8 bits
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com> <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org> <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :
> 
> On Tue, 11 Oct 2005, Eric Dumazet wrote:
> 
>>As NR_CPUS might be > 128, and every spining CPU decrements the lock, we need
>>to use more than 8 bits for a spinlock. The current (i386/x86_64)
>>implementations have a (theorical) bug in this area.
> 
> 
> I don't think there are any x86 machines with > 128 CPU's right now.
> 
> The advantage of the byte lock is that a "movb $0" is three bytes shorter 
> than a "movl $0". And that's the unlock sequence.

1) Would you prefer to change arch/i386/Kconfig

config NR_CPUS
     int "Maximum number of CPUs (2-255)"
     range 2 255

2) The unlock sequence is not anymore inlined. It appears twice or three times 
in the kernel.

3) i386 code is often taken as the base when a port is done. For example 
x86_64 has the same problem.

Eric
