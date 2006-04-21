Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWDUTAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWDUTAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDUTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:00:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28567 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750876AbWDUTAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:00:09 -0400
Subject: Re: [PATCH] X86_NUMAQ build fix
From: Dave Hansen <haveblue@us.ibm.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <874q0mwyor.fsf@duaron.myhome.or.jp>
References: <87irp2x69s.fsf@duaron.myhome.or.jp>
	 <1145643558.3373.34.camel@localhost.localdomain>
	 <874q0mwyor.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 11:59:48 -0700
Message-Id: <1145645988.3373.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 03:50 +0900, OGAWA Hirofumi wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> >>  pci-y                          := fixup.o
> >> -pci-$(CONFIG_ACPI)             += acpi.o
> >>  pci-y                          += legacy.o irq.o
> >>  
> >>  pci-$(CONFIG_X86_VISWS)                := visws.o fixup.o
> >>  pci-$(CONFIG_X86_NUMAQ)                := numa.o irq.o
> >>  
> >> +pci-$(CONFIG_ACPI)             += acpi.o
> >
> > Am I reading this wrong, or does this just move the option down a bit?
> > Did you need to change the link order?  Why?
> 
> No, this is not link order. Note that CONFIG_X86_VISWS/CONFIG_X86_NUMAQ
> uses ":=", not "+=".  In case of ACPI=y", it breaks build.

Ahh, so NUMAQ and VISWS don't seem to allow or want ACPI code.
Especially for the NUMAQ, I don't think we should even mess with this
too much.  Just fix it in the build system and directly disallow NUMAQ
&& ACPI. 

We already have this:

menu "ACPI (Advanced Configuration and Power Interface) Support"
        depends on !X86_VISWS

Just add the NUMAQ in there, too.

-- Dave

