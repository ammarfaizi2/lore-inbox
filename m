Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWDUEpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWDUEpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDUEoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:61057 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932243AbWDUEoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:11 -0400
Date: Thu, 20 Apr 2006 21:38:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jmorris@redhat.com,
       sds@tycho.nsa.gov, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/22] selinux: Fix MLS compatibility off-by-one bug
Message-ID: <20060421043836.GJ12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="selinux-fix-mls-compatibility-off-by-one-bug.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ron Yorston <rmy@tigress.co.uk>

Fix an off-by-one error in the MLS compatibility code that was causing
contexts with a MLS suffix to be rejected, preventing sharing partitions
between FC4 and FC5.  Bug reported in
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188068

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 security/selinux/ss/mls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.9.orig/security/selinux/ss/mls.c
+++ linux-2.6.16.9/security/selinux/ss/mls.c
@@ -264,7 +264,7 @@ int mls_context_to_sid(char oldc,
 
 	if (!selinux_mls_enabled) {
 		if (def_sid != SECSID_NULL && oldc)
-			*scontext += strlen(*scontext);
+			*scontext += strlen(*scontext)+1;
 		return 0;
 	}
 

--
