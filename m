Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRLWR7M>; Sun, 23 Dec 2001 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRLWR7C>; Sun, 23 Dec 2001 12:59:02 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:24595 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282799AbRLWR6x>; Sun, 23 Dec 2001 12:58:53 -0500
Date: Sun, 23 Dec 2001 17:58:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Total system lockup with Alt-SysRQ-L
Message-ID: <20011223175846.B27993@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, alt-sysrq-l is a pretty major thing to do, as it has the effect of
killing everything, including init.

When pid1 exits (maybe due to a kill signal), we lockup hard in (iirc)
exit_notify.  I don't remember the details I'm afraid.

Back in 2.3, I had a go at fixing this, Linus rejected the patch saying
that it was doing the wrong thing.  To this day, the kernel still suffers
from this, and I've not had the inclination to spend any more time on it.

So, I'm just letting people know that alt-sysrq-l is rather fatal,
especially if you want to do the following sequence to avoid a fsck:

	alt-sysrq-l
	alt-sysrq-s
	alt-sysrq-u
	alt-sysrq-b

IMHO either alt-sysrq-l should be removed, or someone who knows the logic
behind the linking of tasks together needs to fix exit_notify so it doesn't
enter an infinite loop when init exits.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

