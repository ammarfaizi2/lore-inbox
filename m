Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSK1Q2N>; Thu, 28 Nov 2002 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSK1Q2N>; Thu, 28 Nov 2002 11:28:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:57058 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S265633AbSK1Q2L>; Thu, 28 Nov 2002 11:28:11 -0500
X-Envelope-From: kraxel@bytesex.org
From: Gerd Knorr <kraxel@bytesex.org>
Message-Id: <200211281616.gASGGOE6012229@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RELEASE] module-init-tools 0.8
In-Reply-To: <20021128023017.91FAC2C250@lists.samba.org>
References: <20021128023017.91FAC2C250@lists.samba.org>
Date: Thu, 28 Nov 2002 17:16:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Please report any bugs to rusty@rustcorp.com.au.

System (SuSE 8.1) still doesn't boot up cleanly.  After logging in as
root I can see a number of modprobe processes hanging around in the
process table:

bogomips root ~# ps -ax | grep modprobe
  621 ?        S      0:00 /sbin/modprobe -- char-major-6
  622 ?        D      0:00 /sbin/modprobe -- parport_lowlevel
  805 ?        D      0:00 /sbin/modprobe -- autofs
  809 ?        D      0:00 /sbin/modprobe -- autofs
  867 ?        D      0:00 /sbin/modprobe -- autofs
  872 ?        D      0:00 /sbin/modprobe -- net-pf-17
 1184 ttyS0    S      0:00 grep modprobe
bogomips root ~# grep char-major-6 /etc/modprobe.conf
alias char-major-6 lp
alias char-major-67 coda
bogomips root ~# grep parport_lowlevel /etc/modprobe.conf
alias parport_lowlevel parport_pc

Smells like a deadlock due to request_module() in some modules init
function or something like this.

lsmod doesn't work at this point (hangs too, likely the same lock).
The deadlock prevents any further module loading (autofs, nfs and
others) and makes the system unusable.


Module debugging is next to impossible right now.  The apm.o module
oopses for me in 2.5.50.  ksymoops isn't able to translate any symbol
located in modules.  The in-kernel symbol decoder (CONFIG_KALLSYMS)
doesn't work too.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
