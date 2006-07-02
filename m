Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWGBPiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWGBPiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGBPiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:38:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22933 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932406AbWGBPiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:38:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing uninitialised data
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	<20060626200433.bf0292af.akpm@osdl.org>
	<1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	<20060626220337.06014184.akpm@osdl.org>
	<1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	<20060627170446.30392b00.akpm@osdl.org>
	<1151462735.5793.2.camel@mulgrave.il.steeleye.com>
	<20060627195743.ce18afe3.akpm@osdl.org>
	<1151536204.3377.51.camel@mulgrave.il.steeleye.com>
	<1151600336.6186.9.camel@mulgrave.il.steeleye.com>
	<m1zmfs83fx.fsf@ebiederm.dsl.xmission.com>
	<1151852801.3558.13.camel@mulgrave.il.steeleye.com>
Date: Sun, 02 Jul 2006 09:37:35 -0600
In-Reply-To: <1151852801.3558.13.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Sun, 02 Jul 2006 10:06:41 -0500")
Message-ID: <m1lkrc81c0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> On Sun, 2006-07-02 at 08:52 -0600, Eric W. Biederman wrote:
>> What is the point of using a non-zero logical cpu id?
>> I don't care about the apic id or the equivalent.
>
> Logical CPUs were just an artifact to get dense CPU maps, which is now
> no longer necessary.  There are architectures which have never used
> logical CPUs.  For them, the boot CPU is whatever the BIOS says it is.

So for the patch mentioned earlier in the thread I have no problems.
And I think it makes sense for arch independent code not to care.

But for x86 I am much less convinced.

>> There are cases like machine_shutdown where we care about who
>> the boot cpu is so we can reboot on that cpu.
>
> That's not at all safe:  one of the standard times for CPUs to be
> deconfigured is on boot.  It's really not a good idea to rely on finding
> the same CPU back again to boot on.

You mean besides the fact that the MPspec requires it and reboots
become much more reliable when you do because you don't tickle BIOS bugs?
It is safe because we don't do it if the cpu is not online.

>> As far as I know 
>> the kernel has not abstraction to describe the boot cpu
>> except for giving it logical cpu id 0.  Has an abstraction
>> been added that I'm not aware of?
>
> The kernel has never had an abstraction requiring logical CPUs, let
> alone one requiring that the boot CPU be numbered zero.

x86 cares, and has such code.  Now possibly that is just the generic
subarch, and voyager does not share that code.  But since the
subarch/arch code division is almost invisible on x86 it's hard to say.

Eric
