Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276937AbRJCSQs>; Wed, 3 Oct 2001 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276936AbRJCSQi>; Wed, 3 Oct 2001 14:16:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57384 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276938AbRJCSQd>; Wed, 3 Oct 2001 14:16:33 -0400
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: viro@math.psu.edu, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Oct 2001 12:06:21 -0600
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil>
Message-ID: <m1r8sk1tuq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:

> Alexander Viro <viro@math.psu.edu>:
> > On Tue, 2 Oct 2001, Rob Landley wrote:
> > 
> > > Anybody want to venture an opinion why overwriting executable files that are
> 
> > > currently in use gives you a "text file busy" error, but overwriting shared
> 
> > > libraries that are in use apparently works just fine (modulo a core dump if
> 
> > > you aren't subtle about your run-time patching)?
> > > 
> > > Permissions are still enforced, but it seems to me somebody who cracks root
> 
> > > on a system could potentially modify the behavior of important system
> daemons
> 
> > > without changing their process ID numbers.
> > > 
> > > Did I miss something somewhere?
> > 
> > Somebody who cracks root can attach gdb to a daemon, modify the contents of
> > its text segment and detach.  No need to change any files...
> 
> True, but the original problem still appears to be a bug.
> 
> Even the owner of the file should not be able to write to a busy executable,
> whether it is a shared library, or an executable image. Remove it, yes.
> Create a new one (in a different inode) -  yes.
> 
> But not modify a busy executable.

Have ld-linux.so set the MAP_DENYWRITE bit when it is mapping
the library.

Eric
