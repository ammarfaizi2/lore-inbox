Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWGKMgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWGKMgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGKMgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:36:46 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:43727 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751251AbWGKMgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:36:45 -0400
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <m18xn0lsdq.fsf@ebiederm.dsl.xmission.com>
References: <1152517852.2120.107.camel@localhost.localdomain>
	 <1152540988.7275.7.camel@mulgrave.il.steeleye.com>
	 <m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
	 <1152565096.4027.4.camel@mulgrave.il.steeleye.com>
	 <m18xn0lsdq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 08:36:14 -0400
Message-Id: <1152621374.3575.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 21:42 -0600, Eric W. Biederman wrote:
> But I do agree the subarch header files are clean.
> And no this case except for the fact no one realized that the
> code doesn't even compile on voyager does not show how brittle
> the x86 subarch code is.    Except for the fact that it seems
> obvious that kernel/smp.c is generic code that every smp subarch
> would use.

OK ... that's the mistaken assumption.  kernel/smp.c is not subarch
generic, it's APIC specific.  So all apic using subarchs, which is
pretty much everything except voyager, use it.  Since voyager uses
vic/qic based smp harness, it has its own version of this file (in fact
voyager has a completely separate SMP HAL).

James


