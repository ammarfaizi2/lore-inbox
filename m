Return-Path: <linux-kernel-owner+w=401wt.eu-S932899AbWL0D7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbWL0D7n (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 22:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWL0D7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 22:59:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47869 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbWL0D7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 22:59:42 -0500
Date: Wed, 27 Dec 2006 09:30:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
       Andi Kleen <ak@suse.de>, Alexander van Heukelum <heukelum@fastmail.fm>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061227040022.GA6699@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org> <20061222104056.GB7009@in.ibm.com> <cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 01:43:31PM +0100, Segher Boessenkool wrote:
> >Thanks Jean. Your compressed/head.o looks fine.
> 
> No it doesn't -- the .text.head section doesn't have
> the ALLOC attribute set.  The section then ends up not
> being assigned to an output segment (during the linking
> of vmlinux) and all hell breaks loose.  The linker gives
> you a warning about this btw.
> 

Thanks Segher. You are right. I did not notice that.

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00000000 000034 000044 00  AX  0   0  4
  [ 2] .rel.text         REL             00000000 0005c8 000040 08      8   1  4
  [ 3] .data             PROGBITS        00000000 000078 000000 00  WA  0   0  4
  [ 4] .bss              NOBITS          00000000 000078 001000 00  WA  0   0  4
  [ 5] .text.head        PROGBITS        00000000 000078 00006e 00      0   0  1

.text.head is not type AX so it will be left out from the linked output.
This reminds me that I have put another patch in kernel/head.S creating
a new section .text.head. I think I shall have to put a patch there too
to make it work with older binutils.

Thanks
Vivek
