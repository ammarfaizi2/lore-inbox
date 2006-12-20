Return-Path: <linux-kernel-owner+w=401wt.eu-S965067AbWLTOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWLTOBI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWLTOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:01:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56786 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965067AbWLTOBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:01:06 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <khali@linux-fr.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
Date: Wed, 20 Dec 2006 07:00:11 -0700
In-Reply-To: <20061220141808.e4b8c0ea.khali@linux-fr.org> (Jean Delvare's
	message of "Wed, 20 Dec 2006 14:18:08 +0100")
Message-ID: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> Hi Eric, Vivek, Andi,
>
> One of my test machines (i586, Asus P4P800-X) reboots instantly when I
> try to boot a 2.6.20-rc1 kernel. 2.6.19 and 2.6.19.1 boot OK. I ran a
> git bisect and it pointed me to this patch:

I don't think this is a know issue.

The most straight forward way to debug this is to put infinite
loops in arch/i386/boot/compressed/head.S moving progressively farther
in until you find where the line in head.S that the machine reboots
on you is.

Although it is possible the problem falls in misc.c as well.

If you have a serial console setup we can probably make this
process a little easier.

One hunch is that we did something stupid, and have an instruction
that only executes on an i686 in there somewhere.

> After that the machine boots OK again. Note that I did _not_ enable
> RELOCATABLE. This is admitedly an old system with an old boot loader
> (lilo 22.5.7.2), so if that's a known issue, I'll be happy to install
> something newer. If not, I am willing to provide all the information
> needed to fix the bug.

Thanks.

Eric
