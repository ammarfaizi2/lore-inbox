Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSGSXIL>; Fri, 19 Jul 2002 19:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGSXIL>; Fri, 19 Jul 2002 19:08:11 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14857 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317211AbSGSXIJ>;
	Fri, 19 Jul 2002 19:08:09 -0400
Date: Fri, 19 Jul 2002 16:09:36 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM task control for 2.5.26
Message-ID: <20020719230936.GA24044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These changesets contain the initial LSM framework, offering hooks for
task control.  It includes the default capabilities module, which should
be selected in the kernel configuration if you want to keep the existing
"normal Linux" capabilities mode. 

Please pull from:  bk://lsm.bkbits.net/linus-2.5

These patches were created by Stephen Smalley <sds@tislabs.com> from the
main LSM tree.

If anyone has any questions about these changes, please let us know.

thanks,

greg k-h

 arch/arm/kernel/isa.c     |    2 
 arch/i386/config.in       |    1 
 arch/i386/kernel/entry.S  |    2 
 arch/i386/kernel/ptrace.c |    4 
 fs/exec.c                 |   71 ++----
 include/linux/binfmts.h   |    1 
 include/linux/sched.h     |   10 
 include/linux/security.h  |  383 +++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h    |    2 
 init/main.c               |    2 
 kernel/capability.c       |   19 -
 kernel/exit.c             |   11 -
 kernel/fork.c             |   13 +
 kernel/kmod.c             |    2 
 kernel/ptrace.c           |    8 
 kernel/sched.c            |   41 +++-
 kernel/signal.c           |    3 
 kernel/sys.c              |  178 ++++++++---------
 kernel/uid16.c            |    8 
 Makefile                  |    5 
 security/capability.c     |  471 ++++++++++++++++++++++++++++++++++++++++++++++
 security/Config.help      |    4 
 security/Config.in        |    7 
 security/dummy.c          |  236 +++++++++++++++++++++++
 security/Makefile         |   13 +
 security/security.c       |  249 ++++++++++++++++++++++++
 26 files changed, 1575 insertions(+), 171 deletions(-)
------

ChangeSet@1.663, 2002-07-19 16:01:00-07:00, greg@kroah.com
  LSM:  Enable the security framework.  This includes basic task control hooks.

 Makefile                  |    5 -
 arch/i386/config.in       |    1 
 arch/i386/kernel/entry.S  |    2 
 arch/i386/kernel/ptrace.c |    4 +
 fs/exec.c                 |   71 +++++-------------
 include/linux/binfmts.h   |    1 
 include/linux/sched.h     |   10 +-
 init/main.c               |    2 
 kernel/capability.c       |   19 ++--
 kernel/exit.c             |   11 +-
 kernel/fork.c             |   13 ++-
 kernel/kmod.c             |    2 
 kernel/ptrace.c           |    8 +-
 kernel/sched.c            |   41 ++++++++--
 kernel/signal.c           |    3 
 kernel/sys.c              |  178 +++++++++++++++++++++++-----------------------
 kernel/uid16.c            |    8 +-
 17 files changed, 210 insertions(+), 169 deletions(-)
------

ChangeSet@1.662, 2002-07-19 15:55:59-07:00, greg@kroah.com
  LSM: Add all of the new security/* files for basic task control
  
  This includes the security_* functions, and the default and capability
  modules.

 include/linux/security.h |  383 ++++++++++++++++++++++++++++++++++++++
 security/Config.help     |    4 
 security/Config.in       |    7 
 security/Makefile        |   13 +
 security/capability.c    |  471 +++++++++++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |  236 +++++++++++++++++++++++
 security/security.c      |  249 ++++++++++++++++++++++++
 7 files changed, 1363 insertions(+)
------

ChangeSet@1.661, 2002-07-19 15:07:35-07:00, greg@kroah.com
  LSM: change BUS_ISA to CTL_BUS_ISA to prevent namespace collision with the input subsystem.
  
  This is needed due to the next header file changes.

 arch/arm/kernel/isa.c  |    2 +-
 include/linux/sysctl.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

