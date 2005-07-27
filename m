Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVG0AVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVG0AVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVG0AVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:21:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18059 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262297AbVG0AVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:21:38 -0400
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/23] Don't export machine_restart, machine_halt, or
 machine_power_off.
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<20050727015519.614dbf2f.Ballarin.Marc@gmx.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 18:20:57 -0600
In-Reply-To: <20050727015519.614dbf2f.Ballarin.Marc@gmx.de> (Marc Ballarin's
 message of "Wed, 27 Jul 2005 01:55:19 +0200")
Message-ID: <m1oe8p9k0m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin <Ballarin.Marc@gmx.de> writes:

> On Tue, 26 Jul 2005 11:36:01 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> 
>> machine_restart, machine_halt and machine_power_off are machine
>> specific hooks deep into the reboot logic, that modules
>> have no business messing with. Usually code should be calling
>> kernel_restart, kernel_halt, kernel_power_off, or
>> emergency_restart. So don't export machine_restart,
>> machine_halt, and machine_power_off so we can catch buggy users.
>
> The first is reiser4 in fs/reiser4/vfs_ops.c, line 1338.
> (Are filesystems supposed to restart the machine at all?!)

I suspect a call to panic would be more appropriate there.

I actually missed this one as I generated the patches against
Linus's latest tree.

Are we in process context where we can afford to do a clean shutdown
of the machine?  I would have expected an error handling path to
not be able to do better than emergency_restart. 

Regardless a panic sounds much more appropriate and will let the action
taken depend on the users policy.

Eric
