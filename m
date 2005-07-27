Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVG0XXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVG0XXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVG0XXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:23:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261216AbVG0XVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:21:43 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
	<Pine.LNX.4.58.0507271550250.3227@g5.osdl.org>
	<20050727225334.GC6529@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 17:20:48 -0600
In-Reply-To: <20050727225334.GC6529@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 28 Jul 2005 00:53:34 +0200")
Message-ID: <m1oe8n7s4v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> > Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
>> 
>> Considering how many device drivers that are likely broken, I disagree. 
>> Especially since Andrew seems to have trivially found a machine where it 
>> doesn't work.
>
> I'm not sure if we want to do that for 2.6.13, but long term, we
> should just tell drivers to FREEZE instead of inventing reboot
> notifier lists and similar uglynesses...

Then as part of the patch device_shutdown should disappear.  It
is silly to have two functions that want to achieve the same
thing.  

Right now the device driver model is ugly and over complicated in
that case and it needs to be simplified so driver writers have
a chance of getting it correct. 

device_suspend(PMSG_FREEZE) feels more reusable than device_shutdown
so long term it feels right.

But a simple question is why can't you simply use the shutdown
method instead of extending the suspend method in the drivers.

Eric
