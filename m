Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWBXOM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWBXOM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWBXOM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:12:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51364 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751041AbWBXOM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:12:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<1140707358.4672.67.camel@laptopd505.fenrus.org>
	<200602231700.36333.ak@suse.de>
	<1140713001.4672.73.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	<43FE0B9A.40209@keyaccess.nl>
	<Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
	<43FE1764.6000300@keyaccess.nl>
	<Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 07:11:25 -0700
In-Reply-To: <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 23 Feb 2006 15:19:54 -0800 (PST)")
Message-ID: <m1wtfk3kz6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 23 Feb 2006, Rene Herman wrote:
>> 
>> Okay. I suppose the only other option is to make "physical_start" a variable
>> passed in by the bootloader so that it could make a runtime decision? Ie,
>> place us at min(top_of_mem, 4G) if it cared to. I just grepped for
>> PHYSICAL_START and this didn't look _too_ bad.

Well the way to accomplish that is to just load the kernel there and
have it sort itself out.  It would take a rev of the boot protocol
to let the bootloader know it was possible though.

> No can do. You'd have to make the kernel relocatable, and do load-time 
> fixups. Very invasive.

Not really. With the linker able to generate the relocations you can
do it outside of most of the kernel where we have the decompressor.  

Relocating a kernel is fundamentally an architecture dependent thing,
relocations can't work at all on x86-64 for example because of the narrow
window of virtual addresses it needs to run at.

I only haven't submitted the patches because I was too busy stabilizing
the reboot path last time I had time to be working in this area.

After I get some sleep I will dust off my patches and see how
it goes.  x86-64 will probably have regressed but...

> It's certainly _possible_, but it's a whole new stage in the boot, one 
> that we've never done before.

It isn't that new.  There has been interest in this area from the
people working on the  kdump stuff for a long you don't require
options under CONFIG_EMBEDDED to build a kernel for capturing a crash
dump. 

CONFIG_PHYSICAL_START was supposed be the simple interim solution
until we could get relocation patches sorted out and merged.

Eric
