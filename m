Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVGAUrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVGAUrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVGAUrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:47:15 -0400
Received: from web50713.mail.yahoo.com ([68.142.224.80]:39321 "HELO
	web50713.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262542AbVGAUnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:43:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6fyd2MUUMUAxxyowJNCFovDemzk6AczlAHVtKS7pwwVbduq9iLKig/qlbXdOmdhiPW3eEI1G/oJxV35r2yWMmPoeMMEgs2yffPdLjU/csQB9f/lV2lUmo6L37NyMaSTFevExfyXElCffwpT6WVvDqSUifcpqiRVVWGjvFRadfOY=  ;
Message-ID: <20050701204351.94386.qmail@web50713.mail.yahoo.com>
Date: Fri, 1 Jul 2005 13:43:51 -0700 (PDT)
From: Badari Pulavarty <pbadari@yahoo.com>
Subject: [PATCH] 2.6.13-rc1-mm1 audit_log_start() warning fix
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1074257400-1120250631=:94063"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1074257400-1120250631=:94063
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi Andrew,

audit_log_start() seems to take 3 arguments, but
its defined to take only 2 when AUDIT is turned
off. Simple patch to fix it.

security/selinux/avc.c:553:75: macro "audit_log_start"
passed 3 arguments, but takes just 2

Thanks,
Badari

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1074257400-1120250631=:94063
Content-Type: text/x-patch; name="audit-log-start-fix.patch"
Content-Description: 2444494241-audit-log-start-fix.patch
Content-Disposition: inline; filename="audit-log-start-fix.patch"

--- linux-2.6.13-rc1.org/include/linux/audit.h	2005-07-01 12:57:31.000000000 -0700
+++ linux-2.6.13-rc1/include/linux/audit.h	2005-07-01 13:24:21.000000000 -0700
@@ -286,7 +286,7 @@ extern void		    audit_log_lost(const ch
 extern struct semaphore audit_netlink_sem;
 #else
 #define audit_log(c,t,f,...) do { ; } while (0)
-#define audit_log_start(c,t) ({ NULL; })
+#define audit_log_start(c,g,t) ({ NULL; })
 #define audit_log_vformat(b,f,a) do { ; } while (0)
 #define audit_log_format(b,f,...) do { ; } while (0)
 #define audit_log_end(b) do { ; } while (0)

--0-1074257400-1120250631=:94063--
