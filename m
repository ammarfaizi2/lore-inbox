Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWERPuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWERPuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWERPuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:50:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24248 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932088AbWERPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:50:40 -0400
Date: Thu, 18 May 2006 10:50:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: [PATCH 7/9] namespaces: utsname: sysctl hack
Message-ID: <20060518155030.GH28344@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518154700.GA28344@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysctl uts patch.  This clearly will need to be done another way, but
since sysctl itself needs to be container aware, 'the right thing' is
a separate patchset.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/sysctl.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

e03808f9c1b803ff67e396e806c062c97b4073aa
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
1.1.6
