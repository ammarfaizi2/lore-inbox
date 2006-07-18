Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWGRLlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWGRLlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWGRLlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:41:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWGRLlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:41:16 -0400
Date: Tue, 18 Jul 2006 04:40:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, rusty@rustcorp.com.au, zach@vmware.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 05/33] Makefile support to build Xen subarch
Message-Id: <20060718044007.74324d93.akpm@osdl.org>
In-Reply-To: <1153216813.3038.22.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org>
	<20060718091949.842251000@sous-sol.org>
	<1153216813.3038.22.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 12:00:13 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> > plain text document attachment (i386-mach-xen)
> > Use arch/i386/mach-xen when building Xen subarch. The separate
> > subarchitecture allows us to hide details of interfacing with the
> > hypervisor from i386 common code.
> 
> 
> Hi,
> 
> please change the order of your patches next time, by sending the
> makefile and config options first you'll break git bisect...
> 

No, this patch is OK (in that respect).  As long as the git-bisect user
sets CONFIG_XEN=n (and surely he will), things will compile.

That being said,

+mflags-$(CONFIG_X86_XEN)	:= -Iinclude/asm-i386/mach-xen
+mcore-$(CONFIG_X86_XEN)		:= mach-xen
+
 # generic subarchitecture
 mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
 mcore-$(CONFIG_X86_GENERICARCH) := mach-default
@@ -99,6 +103,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/powe
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+CPPFLAGS += $(mflags-y)

This change affects _all_ subarchitectures (by potentially altering their
CPPFLAGS) and it's rather a mystery why one subarch needs the -Ifoo in its
CPPFLAGS whereas all the others do not.
