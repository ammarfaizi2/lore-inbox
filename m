Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVG0PhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVG0PhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVG0Ped
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:34:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31380 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262379AbVG0PdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:33:12 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 09:32:32 -0600
In-Reply-To: <20050727025923.7baa38c9.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 27 Jul 2005 02:59:23 -0700")
Message-ID: <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> My fairly ordinary x86 test box gets stuck during reboot on the
> wait_for_completion() in ide_do_drive_cmd():

Hmm. The only thing I can think of is someone started adding calls
to device_suspend() before device_shutdown().  Not understanding
where it was a good idea I made certain the calls were in there
consistently.  

Andrew can you remove the call to device_suspend from kernel_restart
and see if this still happens?

I would suspect interrupts of being disabled but it looks like
kgdb is working and I think that requires an interrupt to notice
new characters.

Eric
