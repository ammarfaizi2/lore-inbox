Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVIIM13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVIIM13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVIIM13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:27:29 -0400
Received: from relay8.mail.ox.ac.uk ([129.67.1.171]:25522 "EHLO
	relay8.mail.ox.ac.uk") by vger.kernel.org with ESMTP
	id S1750767AbVIIM13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:27:29 -0400
Date: Fri, 9 Sep 2005 13:27:26 +0100
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13: loop ioctl crashes
Message-ID: <20050909132725.C23462@pixie.comlab>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying out PPDD from https://retiisi.dyndns.org/~sailus/ppdd/
because I have some old stuff in that format.  However, the crash
seems to occur in code that isn't touched by the PPDD patch.  It
happens while I'm trying to set up the loop device - I haven't got
as far as actually using it yet.

If I'm lucky then when I issue the losetup command and successfully
type in the passphrase then losetup says something of the form
ioctl: LOOP_SET_STATUS: Bad address
and the kernel says:

 Debug: sleeping function called from invalid context at arch/i386/lib/usercopy.c:634
 in_atomic():1, irqs_disabled():0
  [<c011f8eb>] __might_sleep+0xab/0xc0
  [<c0211aa3>] copy_from_user+0x23/0x90
  [<d0a9fe80>] loop_set_status_old+0x30/0x70 [loop]

However, it often seems to panic in a variety of horrible ways while
trying to print the above message.

Clearly I have CONFIG_DEBUG_SPINLOCK_SLEEP set (as my config is
based on Fedora's), and I suppose I could just try unsetting it to
make the message go away.  That wouldn't make the underlying bug go
away, though.  If it makes any difference, loop and all the crypto
algorithms are compiled as modules.

I don't understand why it's an invalid context.  I also don't understand
why the traceback stops at loop_set_status_old given that it must have
been called from lo_ioctl.  (But maybe the answer to the latter would
explain the former.)

I may try just moving the copy_from_user() out to the beginning of
lo_ioctl and see what happens.  Any other suggestions?  In case it's
not obvious by now, I'm not really a kernel hacker.

imc
