Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVGAUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVGAUku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVGAUi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:38:59 -0400
Received: from web50709.mail.yahoo.com ([206.190.38.250]:50530 "HELO
	web50709.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261585AbVGAUhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:37:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kLOlpaQW+x9qZilpUHSfsFINfhJ+hsdXjc+HGkIPYEAz31bRxCwa/hI3fgP9kw9m/mN8uheqLkB0M8BE7IiD2HtpqxjSn9vFXqRdBV5/BJbo4C37i7YD+qh9JiF3KMiVKyHzpaOrS5wdbtgiV2vYUwyd9xMaOrhr1LIEHQ8XrhU=  ;
Message-ID: <20050701203706.72014.qmail@web50709.mail.yahoo.com>
Date: Fri, 1 Jul 2005 13:37:06 -0700 (PDT)
From: Badari Pulavarty <pbadari@yahoo.com>
Subject: [PATCH] 2.6.13-rc1-mm1 make selinux depend on AUDIT
To: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-588158451-1120250226=:71464"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-588158451-1120250226=:71464
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi Andrew,

I ran into this while testing various config options.
It looks like SELINUX doesn't compile without AUDIT.

security/selinux/avc.c:553:75: macro "audit_log_start"
passed 3 arguments, but takes just 2
security/selinux/avc.c: In function `avc_audit':
security/selinux/avc.c:553: error: `audit_log_start'
undeclared (first use in this function)
security/selinux/avc.c:553: error: (Each undeclared
identifier is reported only once
security/selinux/avc.c:553: error: for each function
it appears in.)


Thanks,
Badari

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-588158451-1120250226=:71464
Content-Type: text/x-patch; name="selinux-audit.patch"
Content-Description: 3074542365-selinux-audit.patch
Content-Disposition: inline; filename="selinux-audit.patch"

--- linux-2.6.13-rc1.org/security/selinux/Kconfig	2005-07-01 13:18:39.000000000 -0700
+++ linux-2.6.13-rc1/security/selinux/Kconfig	2005-07-01 13:11:35.000000000 -0700
@@ -1,6 +1,6 @@
 config SECURITY_SELINUX
 	bool "NSA SELinux Support"
-	depends on SECURITY && NET && INET
+	depends on SECURITY && NET && INET && AUDIT
 	default n
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).

--0-588158451-1120250226=:71464--
