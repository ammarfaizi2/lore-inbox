Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVG0AaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVG0AaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVG0A2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:28:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262412AbVG0A1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:27:40 -0400
Date: Tue, 26 Jul 2005 17:26:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Ballarin.Marc@gmx.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/23] Don't export machine_restart, machine_halt, or
 machine_power_off.
Message-Id: <20050726172640.5803950d.akpm@osdl.org>
In-Reply-To: <m1oe8p9k0m.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<20050727015519.614dbf2f.Ballarin.Marc@gmx.de>
	<m1oe8p9k0m.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Marc Ballarin <Ballarin.Marc@gmx.de> writes:
> 
> > On Tue, 26 Jul 2005 11:36:01 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >> 
> >> machine_restart, machine_halt and machine_power_off are machine
> >> specific hooks deep into the reboot logic, that modules
> >> have no business messing with. Usually code should be calling
> >> kernel_restart, kernel_halt, kernel_power_off, or
> >> emergency_restart. So don't export machine_restart,
> >> machine_halt, and machine_power_off so we can catch buggy users.
> >
> > The first is reiser4 in fs/reiser4/vfs_ops.c, line 1338.
> > (Are filesystems supposed to restart the machine at all?!)
> 
> I suspect a call to panic would be more appropriate there.
> 

That's all stuff which the reiser4 team are supposed to be removing, so
I'll add this patch to -mm for now just to keep things happy, thanks.
