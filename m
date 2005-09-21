Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIUCKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIUCKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVIUCKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 22:10:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9867 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750734AbVIUCKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 22:10:22 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
	<m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
	<20050920210617.GA1779@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 20 Sep 2005 20:08:07 -0600
In-Reply-To: <20050920210617.GA1779@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 20 Sep 2005 23:06:17 +0200")
Message-ID: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> In the lead up to 2.6.13 I fixed a large number of reboot
>> problems by making the calling conventions consistent.  Despite
>> checking and double checking my work it appears I missed an
>> obvious one.
>> 
>> The S4 suspend code for PM_DISK_PLATFORM was also calling
>> device_shutdown without setting system_state, and was
>> not calling the appropriate reboot_notifier.
>
> ACK on both. But should not you submit patch via -mm, so it gets at
> least some testing there?

The code is obviously correct, and the people with the problem
have reported that this approach solves it.

If this bit of functionality is to even work we need to do
something like this.

So I don't see what benefit putting this in -mm would give.  If
I was aggressive I would say that this needs to be in 2.6.13.N.
If I'm not following some procedure I don't have a problem
changing though.

This is the final fix I know of to get a consistent set of semantics
for the everything in the ``reboot path''.

>From a practical standpoint I am very tardy in getting this out.

Eric
