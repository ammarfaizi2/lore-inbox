Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWEJCN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWEJCN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEJCNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:13:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:41905 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932379AbWEJCL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:11:57 -0400
Date: Tue, 9 May 2006 21:11:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 7/9] uts namespaces: sysctl hack
Message-ID: <20060510021154.GH32523@sergelap.austin.ibm.com>
References: <29vfyljM-6.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

fa8b556327b97050aa7259da741567b2deb0f32a
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

