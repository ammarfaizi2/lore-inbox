Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUHQE7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUHQE7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHQE7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:59:04 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:5002 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262547AbUHQE66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:58:58 -0400
Date: Tue, 17 Aug 2004 08:59:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817065901.GB7173@mars.ravnborg.org>
Mail-Followup-To: Nathan Lynch <nathanl@austin.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <121120000.1092699569@flay> <1092706344.3081.4.camel@booger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092706344.3081.4.camel@booger>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 08:32:24PM -0500, Nathan Lynch wrote:
> On Mon, 2004-08-16 at 18:39, Martin J. Bligh wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm1
> > 
> > make install from this config file:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq
> > 
> > results in this failure:
> > 
> > make: *** No rule to make target `.tmp_kallsyms2.S', needed by `.tmp_kallsyms2.o'.  Stop.
> 
> I hit the same thing on ppc64 with gcc 3.3.2-ish.  Doing a non-parallel
> make (i.e. without -j) seems to work around it for me.
Fix below:

	Sam

===== Makefile 1.516 vs edited =====
--- 1.516/Makefile	2004-08-12 23:09:08 +02:00
+++ edited/Makefile	2004-08-16 23:40:09 +02:00
@@ -600,6 +600,9 @@
 .tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
+# Needs to visit scripts/ before $(KALLSYMS) can be used.
+$(KALLSYMS): scripts ;
+
 endif
 
 # Finally the vmlinux rule

