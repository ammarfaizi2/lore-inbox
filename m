Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbUKTPKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbUKTPKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUKTPKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:10:18 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:29021 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262980AbUKTPJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:09:00 -0500
Message-ID: <419F5E28.7070606@microgate.com>
Date: Sat, 20 Nov 2004 09:09:28 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"
References: <20041019131240.A20243@flint.arm.linux.org.uk> <20041120131159.C13550@flint.arm.linux.org.uk> <1100954046.11951.0.camel@localhost.localdomain> <20041120142104.D13550@flint.arm.linux.org.uk>
In-Reply-To: <20041120142104.D13550@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Nov 20, 2004 at 12:34:07PM +0000, Alan Cox wrote:
> 
>>On Sad, 2004-11-20 at 13:11, Russell King wrote:
>>
>>>So, what can I do with this bug?  Just close or reject it, or what?
>>>Maybe Alan or Paul would like to assign this bug to themselves?
>>>
>>
>>I thought that was fixed in 10rc and 2.6.9-ac
> 
> 
> Maybe, I have no idea - no one updated the bug, and I'd just like to
> get rid of it one way or the other.

This was fixed (post 2.6.9) with the addition of the ldisc->hangup
method in the ppp_async and ppp_synctty line disciplines.

The bug reporter has a Windows NT server that terminates
the connection without sending the proper LCP packets.
The Linux box had previously relied on DCD negation
to indicate loss of connection via hangup. Alan's
locking changes removed the ldisc->close from do_hangup()
so the line discipline was no longer aware of the hangup.
Adding the ldisc->hangup method restored
detection of connection loss.

I reproduced this in lab, and tested the fix successfully.
I don't remember which version the patch was accepted.

--
Paul Fulghum
paulkf@microgate.com
