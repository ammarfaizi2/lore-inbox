Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWJNDEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWJNDEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWJNDEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 23:04:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16593 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030227AbWJNDEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 23:04:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.18 - check for chroot, broken root and cwd values in procfs
References: <20061012140224.GA7632@wavehammer.waldi.eu.org>
	<20061013230617.GA15489@wavehammer.waldi.eu.org>
Date: Fri, 13 Oct 2006 21:02:50 -0600
In-Reply-To: <20061013230617.GA15489@wavehammer.waldi.eu.org> (Bastian Blank's
	message of "Sat, 14 Oct 2006 01:06:17 +0200")
Message-ID: <m1pscvfvl1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank <bastian@waldi.eu.org> writes:

> On Thu, Oct 12, 2006 at 04:02:24PM +0200, Bastian Blank wrote:
>> The commit 778c1144771f0064b6f51bee865cceb0d996f2f9 replaced the old
>> root-based security checks in procfs with processed based ones.
>
> The new behaviour even allows a user to escape from the chroot by using
> chdir to /proc/$pid/cwd or /proc/$pid/root of a process he owns and
> lives outside of the chroot.

Yep.  It makes it obvious that you can do that.

If you were in a chroot you could always ptrace a process you own
that was outside of the chroot, and cause it to do things, such as
open a unix domain socket and pass you it's current root directory.

chroot by itself has never been much of a jail.

Eric
