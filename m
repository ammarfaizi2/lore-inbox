Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWKBAq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWKBAq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWKBAq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:46:26 -0500
Received: from ozlabs.org ([203.10.76.45]:6577 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751417AbWKBAq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:46:26 -0500
Subject: Re: [PATCH 6/7] paravirtualization: Add APIC accessors to
	paravirt-ops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061101153102.a192f6c9.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
	 <1162377043.23462.12.camel@localhost.localdomain>
	 <1162377093.23462.14.camel@localhost.localdomain>
	 <1162377150.23462.16.camel@localhost.localdomain>
	 <20061101153102.a192f6c9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:46:23 +1100
Message-Id: <1162428383.6848.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:31 -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:32:30 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > +static __inline void apic_write(unsigned long reg, unsigned long v)
> > +static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
> > +static __inline unsigned long apic_read(unsigned long reg)
> 
> Just `inline', please.

akpm says: "Just `inline', please."

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 3a3bc9aed04c include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Nov 02 11:42:22 2006 +1100
+++ b/include/asm-i386/paravirt.h	Thu Nov 02 11:44:15 2006 +1100
@@ -304,17 +304,17 @@ static inline void slow_down_io(void) {
 /*
  * Basic functions accessing APICs.
  */
-static __inline void apic_write(unsigned long reg, unsigned long v)
+static inline void apic_write(unsigned long reg, unsigned long v)
 {
 	paravirt_ops.apic_write(reg,v);
 }
 
-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+static inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
 	paravirt_ops.apic_write_atomic(reg,v);
 }
 
-static __inline unsigned long apic_read(unsigned long reg)
+static inline unsigned long apic_read(unsigned long reg)
 {
 	return paravirt_ops.apic_read(reg);
 }


