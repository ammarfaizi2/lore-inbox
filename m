Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWBXSMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWBXSMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBXSMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:12:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932263AbWBXSMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:12:45 -0500
Date: Fri, 24 Feb 2006 10:11:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <43FF48F2.70508@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0602241007360.22647@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
 <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
 <43FE1764.6000300@keyaccess.nl> <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
 <43FE4B00.8080205@keyaccess.nl> <m1r75s3kfi.fsf@ebiederm.dsl.xmission.com>
 <43FF26A8.9070600@keyaccess.nl> <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0602240925170.3771@g5.osdl.org> <43FF48F2.70508@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Feb 2006, Rene Herman wrote:
> 
> The notion was that having a fixed virtual mapping of the kernel would allow
> it to be loaded anywhere physically without needing to do actual address
> fixups.

Even that doesn't much help. You'd still need to fix up the actual 
addresses.

Why? The virtual remapping is limited to 4MB chunks in order to be able to 
remap using large pages (2MB in PAE mode). At which point there is no 
advantage: you might as well just hardcode the default address to 4MB like 
my trivial one-liner did (with an option for EMBEDDED people to link it 
lower).

So if the point is that we want to use the same binary for both machines 
with less than 4M and for bigger machines, you can't remap the kernel, 
unless you start using individual pages, at which point you've destroyed 
the biggest reason for doing this in the first place - since your TLB 
behaviour will suck.

		Linus
