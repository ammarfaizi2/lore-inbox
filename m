Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWIGGEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWIGGEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWIGGEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:04:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13486 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751935AbWIGGEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:04:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: piet@bluelane.com
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	<m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
	<200609062122.14971.ak@suse.de>
	<1157608031.14930.27.camel@piet2.bluelane.com>
Date: Thu, 07 Sep 2006 00:03:21 -0600
In-Reply-To: <1157608031.14930.27.camel@piet2.bluelane.com> (Piet Delaney's
	message of "Wed, 06 Sep 2006 22:47:11 -0700")
Message-ID: <m1odtsrz6e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney <piet@bluelane.com> writes:

> On Wed, 2006-09-06 at 21:22 +0200, Andi Kleen wrote:
>> On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
>> > 
>> > kexec has been marked experimental for a year now and all
>> > of the serious problems have been worked through.  So it
>> > is time (if not past time) to remove the experimental mark.
>> > 
>> 
>> Hmm, I personally have some doubts it is really not experimental
>> (not because of the kexec code itself, but because of all the other drivers
>> that still break)
>
> What drivers does kexec break?

Kexec doesn't break any drivers.  kexec exposes bugs in driver initialization
handling, when drivers on not robust.

The normal kexec case should be quite simple to handle and because we cleanup
just like a reboot, the difference is that we don't ask the BIOS to reset us
first.

The kexec on panic case is painful, because drivers in the original kernel are
not stopped or shutdown, and so the secondary kernel gets to initialize drivers
from an essentially random state.

Eric
