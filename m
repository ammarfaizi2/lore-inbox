Return-Path: <linux-kernel-owner+w=401wt.eu-S932572AbWLZNE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWLZNE1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 08:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLZNE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 08:04:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:57504 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbWLZNE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 08:04:26 -0500
X-Greylist: delayed 1174 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 08:04:25 EST
In-Reply-To: <20061222104056.GB7009@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org> <20061222104056.GB7009@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
       Andi Kleen <ak@suse.de>, Alexander van Heukelum <heukelum@fastmail.fm>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Date: Tue, 26 Dec 2006 13:43:31 +0100
To: vgoyal@in.ibm.com
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Jean. Your compressed/head.o looks fine.

No it doesn't -- the .text.head section doesn't have
the ALLOC attribute set.  The section then ends up not
being assigned to an output segment (during the linking
of vmlinux) and all hell breaks loose.  The linker gives
you a warning about this btw.

Jean, how old is your binutils?
Since 2.15 at least this should be set automatically
on sections named .text.<whatever> .

It wouldn't hurt to specify it by hand in the source
code of course -- change

.section ".text.head"

to

.section ".text.head","ax",@progbits

in compressed/head.S .


Segher

