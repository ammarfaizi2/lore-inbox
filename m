Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWCSSGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWCSSGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCSSGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:06:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:39388 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932146AbWCSSGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:06:44 -0500
Message-ID: <441D9DA8.90807@linux.intel.com>
Date: Sun, 19 Mar 2006 19:06:32 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5 of 8] Add the __stack_chk_fail() function
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>	<1142612087.3033.110.camel@laptopd505.fenrus.org> <878xr62u70.fsf@hades.wkstn.nix>
In-Reply-To: <878xr62u70.fsf@hades.wkstn.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
> On 17 Mar 2006, Arjan van de Ven wrote:
>> GCC emits a call to a __stack_chk_fail() function when the cookie is not 
>> matching the expected value. Since this is a bad security issue; lets panic
>> the kernel
> 
> This turns even minor buffer overflows into complete denials of service.

only those who otherwise would get to the return address. So it turns a "own the machine" into a panic.
Not a "no side effects" thing....


> If we're running in process context and the process is currently
> killable it might make more sense to printk() a message and zap the
> process; that way we only halt whatever service it is the attacker
> hit us through.

maybe. The big question is if you can still trust the machine. That is highly questionable...
(and to kill the process you again need to trust bits of the stack, to get to current for example;
and you just found that the stack was compromised)
