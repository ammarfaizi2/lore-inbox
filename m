Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDTRDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDTRDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDTRDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:03:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:25825 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751144AbWDTRDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:03:08 -0400
Date: Thu, 20 Apr 2006 10:01:53 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Christoph Hellwig <hch@infradead.org>,
       tonyj@suse.de, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] make security_ops EXPORT_SYMBOL_GPL()
Message-ID: <20060420170153.GA3237@kroah.com>
References: <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com> <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil> <20060420161552.GA1990@kroah.com> <20060420162309.GA18726@infradead.org> <1145550897.3313.143.camel@moss-spartans.epoch.ncsc.mil> <20060420164651.GA2439@kroah.com> <1145552412.3313.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145552412.3313.150.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some closed source modules are taking advantage of the fact that the
security_ops variable is available to them, so they are using it to hook
into parts of the kernel that should only be available to "real" users
of the LSM interface (which is required to be under the GPL.)

This patch changes the export of that variable to try to mitigate the
problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 security/security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/security/security.c
+++ gregkh-2.6/security/security.c
@@ -178,4 +178,4 @@ EXPORT_SYMBOL_GPL(register_security);
 EXPORT_SYMBOL_GPL(unregister_security);
 EXPORT_SYMBOL_GPL(mod_reg_security);
 EXPORT_SYMBOL_GPL(mod_unreg_security);
-EXPORT_SYMBOL(security_ops);
+EXPORT_SYMBOL_GPL(security_ops);
