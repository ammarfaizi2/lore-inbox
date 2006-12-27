Return-Path: <linux-kernel-owner+w=401wt.eu-S932906AbWL0EZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWL0EZj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbWL0EZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:25:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:35277 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906AbWL0EZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:25:38 -0500
In-Reply-To: <20061227040022.GA6699@in.ibm.com>
References: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org> <20061222104056.GB7009@in.ibm.com> <cd59f61239daf052c6b8038f4d3f57b8@kernel.crashing.org> <20061227040022.GA6699@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f3dd667a7a49168e6817600f196e29bc@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
       Andi Kleen <ak@suse.de>, Alexander van Heukelum <heukelum@fastmail.fm>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Date: Wed, 27 Dec 2006 05:25:29 +0100
To: vgoyal@in.ibm.com
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .text.head is not type AX so it will be left out from the linked 
> output.

No, it does get added, but the section is not added to
any segment, so a) it ends up near the end of the address
map instead of being first thing, and b) it won't be loaded
at run time.

> This reminds me that I have put another patch in kernel/head.S creating
> a new section .text.head. I think I shall have to put a patch there too
> to make it work with older binutils.

Yeah.  Current stuff works with 2.15, which is three years
old, but it doesn't hurt supporting older toolchains where
possible.


Segher

