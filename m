Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJQD0y>; Wed, 16 Oct 2002 23:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSJQD0y>; Wed, 16 Oct 2002 23:26:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37375 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261746AbSJQD0u>; Wed, 16 Oct 2002 23:26:50 -0400
Date: Wed, 16 Oct 2002 23:33:02 -0400
From: Doug Ledford <dledford@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, linux-scsi@vger.kernel.org
Subject: 2.5.43 IO-APIC bug and spinlock deadlock
Message-ID: <20021017033302.GP8159@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
fails (does *everyone* run SMP or at least UP + APIC now?)

spinlock deadlock: run an smp kernel on a up machine.  On mine here all I 
have to do is try to boot to multiuser mode, it won't make it through the 
startup scripts before it locks up by trying to reenter common_interrupt 
on the only CPU.  Seems like an SMP kernel on UP hardware doesn't disable 
interrupts properly maybe?  I get task lists via alt-sysreq when the 
machine should be hardlocked I think.  Anyway, this is what has been 
tricking me into thinking I had an IDE problem.  IDE is innocent, it's the 
core interrupt handling code.

Back to work on scsi stuff now that I have a decently running 2.5.43
system, I'll let someone else deal with these.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
