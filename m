Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965918AbWKXSR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965918AbWKXSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965919AbWKXSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:17:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50155 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965916AbWKXSR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:17:57 -0500
Date: Fri, 24 Nov 2006 12:17:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Friedhoff <chris@friedhoff.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: file caps: permit unsafe signaling when CONFIG_FS_CAPS=n
Message-ID: <20061124181742.GA32443@sergelap.austin.ibm.com>
References: <20061114030655.GB31893@sergelap> <20061123001458.fe73f64a.akpm@osdl.org> <20061123002207.5e18bade.akpm@osdl.org> <20061123131203.f7b6972f.chris@friedhoff.org> <20061123103920.8d908952.akpm@osdl.org> <20061124161626.GA22462@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124161626.GA22462@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Ok, the following patch restores the CONFIG_FS_CAPS=n signaling
> behavior, but I'm having a config problem.  When
> CONFIG_SECURITY_CAPABILITIES=n, and I toggle
> CONFIG_SECURITY_FS_CAPABILITIES between y and n, security/commoncap.o
> does not recompile.  However since capabilities are now the default
> security module, commoncap.o is in fact included in the kernel build,
> and therefore should be recompiled.
> 
> Looking into why, but maybe someone knows offhand what would be going
> wrong?

Uh, never mind.  It does the right thing.  CONFIG_SECURITY=n means we
use capabilities, but CONFIG_SECURITY=y and CONFIG_SECURITY_CAPABILITIES=n 
means we use dummy.  The following patch fixes the Kconfig accordingly.

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] file caps: don't show FILE_CAPABILITIES option when not relevant

FILE_CAPABILITIES are relevant when CONFIG_SECURITY=n, but not when
CONFIG_SECURITY=y && CONFIG_SECURITY_CAPABILITIES=n.  So make
CONFIG_SECURITY_FS_CAPABILITIES depend on the right conditions.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 6c9d69e..1b47f01 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -82,6 +82,7 @@ config SECURITY_CAPABILITIES
 
 config SECURITY_FS_CAPABILITIES
 	bool "File POSIX Capabilities"
+	depends on SECURITY=n || SECURITY_CAPABILITIES=y
 	default n
 	help
 	  This enables filesystem capabilities, allowing you to give
-- 
1.4.1

