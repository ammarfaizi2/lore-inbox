Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWGBPG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWGBPG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGBPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:06:59 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:31180 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932248AbWGBPG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:06:58 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <m1zmfs83fx.fsf@ebiederm.dsl.xmission.com>
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
Content-Type: text/plain
Date: Sun, 02 Jul 2006 10:06:41 -0500
Message-Id: <1151852801.3558.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 08:52 -0600, Eric W. Biederman wrote:
> What is the point of using a non-zero logical cpu id?
> I don't care about the apic id or the equivalent.

Logical CPUs were just an artifact to get dense CPU maps, which is now
no longer necessary.  There are architectures which have never used
logical CPUs.  For them, the boot CPU is whatever the BIOS says it is.

> There are cases like machine_shutdown where we care about who
> the boot cpu is so we can reboot on that cpu.

That's not at all safe:  one of the standard times for CPUs to be
deconfigured is on boot.  It's really not a good idea to rely on finding
the same CPU back again to boot on.

> As far as I know 
> the kernel has not abstraction to describe the boot cpu
> except for giving it logical cpu id 0.  Has an abstraction
> been added that I'm not aware of?

The kernel has never had an abstraction requiring logical CPUs, let
alone one requiring that the boot CPU be numbered zero.

James


