Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbSLLBrF>; Wed, 11 Dec 2002 20:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSLLBrF>; Wed, 11 Dec 2002 20:47:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9744 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267388AbSLLBrD>;
	Wed, 11 Dec 2002 20:47:03 -0500
Date: Wed, 11 Dec 2002 17:53:26 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
Message-ID: <20021212015326.GI16615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a bk tree with two changesets that fix some problems with
mpparse.c.

The first patch fixes a problem for machines that have more busses or
irq sources than MAX_MP_BUSSES or MAX_IRQ_SOURCES has been set to.  This
happens on some Intel Foster machines (or whatever they are calling the
processors now) when a PCI bus expansion unit is plugged in at boot
time.
  
Without this patch, those machines can not boot Linux.
  
If the machine needs more busses or interrupts, they will be dynamically
allocated at boot time.  If not, the existing MAX_MP_BUSSES and
MAX_IRW_SOURCES value will be used.  Once nice side effect of this patch
is when running a SMP kernel on a UP machine without a MP table, less
kernel memory is used than without the patch.
  
This patch was originally written by James Cleverdon, and has been in
the -ac tree for quite some time.  I also think Red Hat includes it in
their main kernel, but am not sure.

There's also a minor patch to fix a formatting error in mpparse.c too.

Please pull from:
	bk://linuxusb.bkbits.net/marcelo-smp-2.4

Patches will be sent as a response to this message for those who want to
see them.

thanks,

greg k-h



 arch/i386/kernel/mpparse.c |   80 +++++++++++++++++++++++++++++++++++++++++----
 include/asm-i386/io_apic.h |    2 -
 include/asm-i386/mpspec.h  |   12 ++----
 3 files changed, 79 insertions(+), 15 deletions(-)
-----

ChangeSet@1.813, 2002-12-11 17:44:54-08:00, greg@kroah.com
  mpparse.c: Fix a minor code formatting issue.

 arch/i386/kernel/mpparse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.812, 2002-12-11 11:53:05-08:00, greg@kroah.com
  [PATCH] dynamic MAX_MP_BUSSES and MAX_IRQ_SOURCES
  
  Here's a patch that fixes a problem for machines
  that have more busses or irq sources than MAX_MP_BUSSES or
  MAX_IRQ_SOURCES has been set to.  This happens on some Intel Foster
  machines (or whatever they are calling the processors now) when a PCI
  bus expansion unit is plugged in at boot time.
  
  Without this patch, those machines can not boot Linux.
  
  If the machine needs more busses or interrupts, they will be dynamically
  allocated at boot time.  If not, the existing MAX_MP_BUSSES and
  MAX_IRW_SOURCES value will be used.  Once nice side effect of this patch
  is when running a SMP kernel on a UP machine without a MP table, less
  kernel memory is used than without the patch.
  
  This patch was originally written by James Cleverdon.

 arch/i386/kernel/mpparse.c |   78 +++++++++++++++++++++++++++++++++++++++++----
 include/asm-i386/io_apic.h |    2 -
 include/asm-i386/mpspec.h  |   12 ++----
 3 files changed, 78 insertions(+), 14 deletions(-)
------

