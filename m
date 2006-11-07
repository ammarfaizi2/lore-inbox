Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965591AbWKGReb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbWKGReb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965603AbWKGReb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:34:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12763 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965591AbWKGRea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:34:30 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
Date: Tue, 07 Nov 2006 10:33:36 -0700
In-Reply-To: <4550B22C.1060307@serpentine.com> (Bryan O'Sullivan's message of
	"Tue, 07 Nov 2006 08:19:56 -0800")
Message-ID: <m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> writes:

> Eric W. Biederman wrote:
>
>> How comes the driver fixes in the context of my patches?
>
> The fix is simple enough, it's just not as clean as I'd like.  I have to pull
> apart the contents of the ht_irq_msg that the new update hook is getting passed,
> in order to get the vector out, so that I can reprogram the offending chip
> register after I've done the config space writes. It's a pretty roundabout way
> to do the job.

Huh?  As I read the ipath code I am passing you the value that needs to go
into ipath->int_config and thus into dd->ipath_kregs->kr_interrupt_config.

Sure it is coming as 2 32bit words instead of a one big 64 bit one, but
that is simple to fix.

If your card doesn't pay attention to configuration space access cycles then
there should be no reason to write the value there.   If your card does pay
attention to the configuration space access cycles it should be trivial to
make this work.

Please stop getting stuck on your existing hack that only put in the vector
number and didn't put in any of the other interrupt routing information.

If you really need to write to both the config space registers and your
magic shadow copy of the register I can certainly do the config space
writes for you.  I just figured it would be more efficient not to.

Eric
