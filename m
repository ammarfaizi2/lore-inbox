Return-Path: <linux-kernel-owner+w=401wt.eu-S932598AbWLZOC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWLZOC4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 09:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWLZOC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 09:02:56 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:4082 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932598AbWLZOCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 09:02:55 -0500
Date: Tue, 26 Dec 2006 15:03:02 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander van Heukelum <heukelum@fastmail.fm>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20061226150302.85606ac4.khali@linux-fr.org>
In-Reply-To: <cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221145922.16ee8dd7.khali@linux-fr.org>
	<1166723157.29546.281560884@webmail.messagingengine.com>
	<20061221204408.GA7009@in.ibm.com>
	<20061222090806.3ae56579.khali@linux-fr.org>
	<20061222104056.GB7009@in.ibm.com>
	<cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Segher,

On Tue, 26 Dec 2006 13:43:31 +0100, Segher Boessenkool wrote:
> > Thanks Jean. Your compressed/head.o looks fine.
> 
> No it doesn't -- the .text.head section doesn't have
> the ALLOC attribute set.  The section then ends up not
> being assigned to an output segment (during the linking
> of vmlinux) and all hell breaks loose.  The linker gives
> you a warning about this btw.

I didn't notice any warning, but maybe I just missed it.

> Jean, how old is your binutils?

2.14.90.0.6

> Since 2.15 at least this should be set automatically
> on sections named .text.<whatever> .
> 
> It wouldn't hurt to specify it by hand in the source
> code of course -- change
> 
> .section ".text.head"
> 
> to
> 
> .section ".text.head","ax",@progbits
> 
> in compressed/head.S .

I don't have access to this test system at the moment, I'll check, test
and report back once I have access again.

Thanks,
-- 
Jean Delvare
