Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWCSTGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCSTGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWCSTGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:06:53 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:46349 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750725AbWCSTGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:06:53 -0500
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5 of 8] Add the __stack_chk_fail() function
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
	<1142612087.3033.110.camel@laptopd505.fenrus.org>
	<878xr62u70.fsf@hades.wkstn.nix> <441D9DA8.90807@linux.intel.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: freely redistributable; void where prohibited by law.
Date: Sun, 19 Mar 2006 19:06:48 +0000
In-Reply-To: <441D9DA8.90807@linux.intel.com> (Arjan van de Ven's message of
 "Sun, 19 Mar 2006 19:06:32 +0100")
Message-ID: <87y7z61cfr.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2006, Arjan van de Ven yowled:
> Nix wrote:
>> On 17 Mar 2006, Arjan van de Ven wrote:
>>> GCC emits a call to a __stack_chk_fail() function when the cookie is not matching the expected value. Since this is a bad
>>> security issue; lets panic
>>> the kernel
>> This turns even minor buffer overflows into complete denials of service.
> 
> only those who otherwise would get to the return address. So it turns a "own the machine" into a panic.
> Not a "no side effects" thing....

True. Also...

> maybe. The big question is if you can still trust the machine. That is highly questionable...
> (and to kill the process you again need to trust bits of the stack, to get to current for example;
> and you just found that the stack was compromised)

... that's true, and furthermore it allows the attack vector of
`compromise global state, then allow this process to die and allow
the global compromise to take over the box'.

Possibly for UML images you can core dump the entire UML for later
analysis. Can't do that with Xen, though, unless we can be sure that a
compromised guest can't affect any other guests or the hypervisor (which
we know to be untrue in the case of at least *one[ guest).

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
