Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWEATx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWEATx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWEATx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:53:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:27877 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932210AbWEATx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:56 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 5/7] uts namespaces: sysctl hack
References: <20060501203904.XF1836@sergelap.austin.ibm.com>
Message-ID: <20060501203905.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysctl uts patch.  This clearly will need to be done another way, but
since sysctl itself needs to be container aware, 'the right thing' is
a separate patchset.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/sysctl.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

1ead4c366dd1cd7e6ad0e4d891b34040a3b1e565
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e82726f..ab36b41 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -233,8 +233,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
 		.procname	= "ostype",
-		.data		= system_utsname.sysname,
-		.maxlen		= sizeof(system_utsname.sysname),
+		.data		= init_uts_ns.name.sysname,
+		.maxlen		= sizeof(init_uts_ns.name.sysname),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -242,8 +242,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSRELEASE,
 		.procname	= "osrelease",
-		.data		= system_utsname.release,
-		.maxlen		= sizeof(system_utsname.release),
+		.data		= init_uts_ns.name.release,
+		.maxlen		= sizeof(init_uts_ns.name.release),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -251,8 +251,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_VERSION,
 		.procname	= "version",
-		.data		= system_utsname.version,
-		.maxlen		= sizeof(system_utsname.version),
+		.data		= init_uts_ns.name.version,
+		.maxlen		= sizeof(init_uts_ns.name.version),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -260,8 +260,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_NODENAME,
 		.procname	= "hostname",
-		.data		= system_utsname.nodename,
-		.maxlen		= sizeof(system_utsname.nodename),
+		.data		= init_uts_ns.name.nodename,
+		.maxlen		= sizeof(init_uts_ns.name.nodename),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -269,8 +269,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_DOMAINNAME,
 		.procname	= "domainname",
-		.data		= system_utsname.domainname,
-		.maxlen		= sizeof(system_utsname.domainname),
+		.data		= init_uts_ns.name.domainname,
+		.maxlen		= sizeof(init_uts_ns.name.domainname),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
-- 
1.3.0


