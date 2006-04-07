Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWDGSmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWDGSmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDGSmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:42:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:705 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964854AbWDGSmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:42:22 -0400
To: Mike Hearn <mike@plan99.net>
Cc: Bodo Eggert <7eggert@gmx.de>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it>
	<E1FRSqP-0000g3-9i@be1.lrz> <443515E1.1000600@plan99.net>
	<Pine.LNX.4.58.0604061841150.1941@be1.lrz> <44356DAA.90209@plan99.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 07 Apr 2006 12:40:34 -0600
In-Reply-To: <44356DAA.90209@plan99.net> (Mike Hearn's message of "Thu, 06
 Apr 2006 20:36:10 +0100")
Message-ID: <m164llns9p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn <mike@plan99.net> writes:

> In practice most desktop apps use "prefix paths" to locate their own data
> files. They don't usually send those file paths to other processes, not even in
> the case of things like GIMP plugins.

Programs that ssh to another machine and run commands are likely
to send paths.

>> IMO it's still best to just symlink the program directory to the correct place
>> and make the programs search in e.g. ~/opt/ and /opt/.
>
> That also suffers from namespace conflicts ;)


I looked at your original proposal some more and it fails
miserably for shell scripts.  Basically they all get / as
their prefix, no matter where in the filesystem you put them.

Also there is a very serious problem with suid exectuables.
If a non privileged user has write access to the same filesystem
the exectuables live on they can create a hard link to those
files and change the prefix.  Quite possibly getting the suid
executables to trust a new set of exectuables.

So this scheme appears to have many if not all of same security issues
as private namespaces.

Given that mostly it will be junior programmers packaging applications
behind the backs of the authors of the code that will implement this
scheme we could introduce all kinds of problems that no one will
notice for quite a while.

Eric
