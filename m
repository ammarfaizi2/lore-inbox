Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276167AbRJCMth>; Wed, 3 Oct 2001 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276174AbRJCMt2>; Wed, 3 Oct 2001 08:49:28 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:60910 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S276167AbRJCMtN>; Wed, 3 Oct 2001 08:49:13 -0400
Date: Wed, 3 Oct 2001 07:49:39 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil>
To: viro@math.psu.edu, Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> On Tue, 2 Oct 2001, Rob Landley wrote:
> 
> > Anybody want to venture an opinion why overwriting executable files that are 
> > currently in use gives you a "text file busy" error, but overwriting shared 
> > libraries that are in use apparently works just fine (modulo a core dump if 
> > you aren't subtle about your run-time patching)?
> > 
> > Permissions are still enforced, but it seems to me somebody who cracks root 
> > on a system could potentially modify the behavior of important system daemons 
> > without changing their process ID numbers.
> > 
> > Did I miss something somewhere?
> 
> Somebody who cracks root can attach gdb to a daemon, modify the contents of
> its text segment and detach.  No need to change any files...

True, but the original problem still appears to be a bug.

Even the owner of the file should not be able to write to a busy executable,
whether it is a shared library, or an executable image. Remove it, yes.
Create a new one (in a different inode) -  yes.

But not modify a busy executable.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
