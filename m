Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312104AbSCQUJX>; Sun, 17 Mar 2002 15:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312108AbSCQUJO>; Sun, 17 Mar 2002 15:09:14 -0500
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:29970
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id <S312104AbSCQUJA>; Sun, 17 Mar 2002 15:09:00 -0500
Date: Sun, 17 Mar 2002 12:11:18 -0800
From: Neil Schemenauer <nas@python.ca>
To: linux-kernel@vger.kernel.org
Subject: ANN: capwrap - grant capabilities to executables
Message-ID: <20020317121118.A18548@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a small module¹ that enables the use of Linux capabilities
on filesystems that do not support them.  It is similar in spirit to ELF
capabilities hack² but is not specific to the ELF executable format and
is implemented as separate kernel module.

To grant capabilities to an executable, a small wrapper file is created
that includes the path to an executable followed a capability set
written in hexadecimal.  When this file is executed by the kernel, the
executable is granted the specified capabilities.  The wrapper file must
be owned by root and have the SUID bit set.

For example, to remove the SUID bit on the ping program while retaining
its functionality:

    # chmod -s /bin/ping
    # mv /bin/ping /bin/ping_real
    # echo '&/bin/ping_real 2000' > /bin/ping
    # chmod +xs /bin/ping

Comments welcome.

  Neil


¹ http://arctrix.com/nas/linux/capwrap.tar.gz
² http://atrey.karlin.mff.cuni.cz/~pavel/elfcap.html
