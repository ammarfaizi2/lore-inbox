Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132827AbRC2TXO>; Thu, 29 Mar 2001 14:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRC2TXE>; Thu, 29 Mar 2001 14:23:04 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:2904 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132826AbRC2TWy>; Thu, 29 Mar 2001 14:22:54 -0500
Date: Thu, 29 Mar 2001 13:20:46 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103291920.NAA69574@tomcat.admin.navo.hpc.mil>
To: dlang@diginsite.com, David Konerding <dek_ml@konerding.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

avid Lang <dlang@diginsite.com>:
>one of the key places where the memory is 'allocated' but not used is in
>the copy on write conditions (fork, clone, etc) most of the time very
>little of the 'duplicate' memory is ever changed (in fact most of the time
>the program that forks then executes some other program) on a lot of
>production boxes this would be a _very_ significant additional overhead in
>memory (think a busy apache server, it forks a bunch of processes, but
>currently most of that memory is COW and never actually needs to be
>duplicated)

So? If the requirement is no-overcommit, then assume it WILL be overwritten.
Allocate sufficient swap for the requirement.

Now, it shouldn't be necessary to include the text segment - after all
this should be marked RX.

Actually just X would do, but on Intel systems that also means R. and if W
is set it also means RWX. I hope that Intel gets a better clue about memory
protection sometime soon.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
