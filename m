Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUEYXs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUEYXs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUEYXs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:48:56 -0400
Received: from av2-2-sn3.vrr.skanova.net ([81.228.9.108]:1962 "EHLO
	av2-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265257AbUEYXsn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:48:43 -0400
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Modifying kernel so that non-root users have some root capabilities
Date: Wed, 26 May 2004 01:43:06 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405260143.06439.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity
> 
> Anyone got any ideas about how I could start doing this? (I'm new to
> kernel development, btw.)

Audio development folks has a SELinux module that does almost this.

"The latest version of the realtime Linux Security Module is now
available on SourceForge...

  
http://prdownloads.sourceforge.net/realtime-lsm/realtime-lsm-0.1.1.tar.gz?download

This release handles changes to the capabilities structure introduced
in Linux 2.6.6, but still works with earlier 2.6 kernels.  There are
no functional changes.  Unless you are running 2.6.6, there is no need
to upgrade.  Changes in the 2.6.6 kernel makefiles affect the
procedure for building the realtime-lsm.  Please consult the INSTALL
instructions for details.

The realtime LSM is an installable kernel module that enables realtime
capabilities for any 2.6 kernel without needing to directly patch the
kernel.  It was written by Torben Hohn and Jack O'Quin, who make no
warranty concerning the safety, security or even stability of your
system when using it.  It is provided under the provisions of the GPL.
-- 
  joq"

Usage like this:
"Once the LSM has been installed and the kernel for which it was built
is running, the root user can load it and pass parameters as follows:

  # modprobe realtime any=1

  Any program can request realtime privileges.  This allows any local
  user to crash the system by hogging the CPU in a tight loop or
  locking down too much memory.  But, it is simple to administer.  :-)

  # modprobe realtime gid=29

  All users belonging to group 29 and programs that are setgid to that
  group have realtime privileges.  Use any group number you like.

  # modprobe realtime mlock=0

  Grants realtime scheduling privileges without the ability to lock
  memory using mlock() or mlockall() system calls.  This option can be
  used in conjunction with any of the other options.
"

/RogerL
(not subscribed but reading archives now and then)

-- 
Roger Larsson
Skellefteå
Sweden
