Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSJQIXi>; Thu, 17 Oct 2002 04:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJQIXi>; Thu, 17 Oct 2002 04:23:38 -0400
Received: from kim.it.uu.se ([130.238.12.178]:9405 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261859AbSJQIXf>;
	Thu, 17 Oct 2002 04:23:35 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.29928.793212.310557@kim.it.uu.se>
Date: Thu, 17 Oct 2002 10:29:28 +0200
To: Doug Ledford <dledford@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
In-Reply-To: <20021017051308.GA10276@redhat.com>
References: <20021017033302.GP8159@redhat.com>
	<20021017042851.GQ8159@redhat.com>
	<3DAE3F38.11C9E4F1@digeo.com>
	<20021017051308.GA10276@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford writes:
 > On Wed, Oct 16, 2002 at 09:40:24PM -0700, Andrew Morton wrote:
 > > Doug Ledford wrote:
 > > > 
 > > > On Wed, Oct 16, 2002 at 11:33:02PM -0400, Doug Ledford wrote:
 > > > > IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
 > > > > fails (does *everyone* run SMP or at least UP + APIC now?)
 > > > 
 > > > OK, this is real.
 > > > 
 > > 
 > > Linus has merged a patch for this.  Does it work for you?  I don't
 > > think you've sent us any error output.
 > > 
 > > 
 > >  include/asm-i386/apic.h |    4 ++--
 > >  include/asm-i386/smp.h  |    2 +-
 > >  2 files changed, 3 insertions(+), 3 deletions(-)
 > 
 > No, tried that, didn't work.  Turn off SMP in your config and also turn 
 > off APIC support entirely, that's when it breaks the compile.

Ah, that rings a bell. Does 'grep MPPARSE' find a match in your .config
even though SMP and *APIC are disabled? That's a scripts/Configure bug:
it enables MPPARSE because CONFIG_X86_LOCAL_APIC was enabled at the start
of this Configure run, even though CONFIG_X86_LOCAL_APIC was disabled later.
Another 'make oldconfig' fixes it.
