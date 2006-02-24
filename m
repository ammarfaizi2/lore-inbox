Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWBXOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWBXOYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBXOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:24:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63396 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932146AbWBXOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:24:20 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
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
	<43FE4B00.8080205@keyaccess.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 07:23:04 -0700
In-Reply-To: <43FE4B00.8080205@keyaccess.nl> (Rene Herman's message of "Fri,
 24 Feb 2006 00:53:36 +0100")
Message-ID: <m1slq83kfr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> writes:

> Linus Torvalds wrote:
>
>> On Thu, 23 Feb 2006, Rene Herman wrote:
>
>>> Okay. I suppose the only other option is to make "physical_start" a variable
>>> passed in by the bootloader so that it could make a runtime decision? Ie,
>>> place us at min(top_of_mem, 4G) if it cared to. I just grepped for
>>> PHYSICAL_START and this didn't look _too_ bad.
>> No can do. You'd have to make the kernel relocatable, and do load-time
>> fixups. Very invasive.
>
> Yes, that wasn't too smart. I believe in principe most of it _could_ be done via
> some pagetable trickery though, with the kernel still at a fixed virtual
> address?

The page table trickery is actually the more invasive approach.  I believe
for 32 bit kernels the real problem is giving up the identity mapping of
low memory.  Short of the moving the kernel to end of the address space
where vmalloc and the fixmaps are now I don't think there is a reasonable chunk
of the address space we can use.

Eric
