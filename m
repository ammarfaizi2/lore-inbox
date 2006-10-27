Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752276AbWJ0Pd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbWJ0Pd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWJ0Pd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:33:27 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:46382 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752274AbWJ0Pd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:33:27 -0400
Date: Fri, 27 Oct 2006 08:27:41 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
Message-Id: <20061027082741.8476024a.randy.dunlap@oracle.com>
In-Reply-To: <1161959020.12281.1.camel@laptopd505.fenrus.org>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<20061025205923.828c620d.akpm@osdl.org>
	<20061026102630.ad191d21.randy.dunlap@oracle.com>
	<1161959020.12281.1.camel@laptopd505.fenrus.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 16:23:39 +0200 Arjan van de Ven wrote:

> > ---
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > For ndiswrapper and driverloader, don't set the module->taints
> > flags, just set the kernel global tainted flag.
> > This should allow ndiswrapper to continue to use GPL symbols.
> > Not tested.
> 
> 
> can we put something in feature-removal that we'll undo this in say 6
> months?

It's open for discussion AFAIK.

> ndiswrapper is easy to fix to not use the internals of the queue_work
> api, and just use schedule_work() instead. At that time the
> functionality as a whole is still the right one.
> (it's a separate question if ndiswrapper should be in this table;
> driverloader should be, it's non-GPL at all, so that part of your patch
> is broken)

OK, here's the replacement for only ndiswrapper, not driverloader.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

For ndiswrapper, don't set the module->taints flags,
just set the kernel global tainted flag.
This should allow ndiswrapper to continue to use GPL symbols.
Not tested.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/module.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc3-pv.orig/kernel/module.c
+++ linux-2619-rc3-pv/kernel/module.c
@@ -1718,7 +1718,7 @@ static struct module *load_module(void _
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	if (strcmp(mod->name, "ndiswrapper") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
+		add_taint(TAINT_PROPRIETARY_MODULE);
 	if (strcmp(mod->name, "driverloader") == 0)
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 
