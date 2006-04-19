Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWDSPnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWDSPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDSPnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:43:25 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:6308 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750919AbWDSPnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:43:24 -0400
Message-ID: <44465C47.9050706@sw.ru>
Date: Wed, 19 Apr 2006 19:50:31 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <20060419152129.GA14756@sergelap.austin.ibm.com>
In-Reply-To: <20060419152129.GA14756@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge,

> Please look closer at the patch.
> I *am* doing nothing with sysctls.
 >
> system_utsname no longer exists, and the way to get to that is by using
> init_uts_ns.name.  That's all this does.
Sorry for being not concrete enough.
I mean switch () in the code. Until we decided how to virtualize 
sysctls/proc, I believe no dead code/hacks should be commited. IMHO.

FYI, I strongly object against virtualizing sysctls this way as it is 
not flexible and is a real hack from my POV.

Sure, change of system_utsname.sysname -> init_uts_ns.name.sysname is Ok.

Thanks,
Kirill

>>>Sysctl uts patch.  This clearly will need to be done another way, but
>>>since sysctl itself needs to be container aware, 'the right thing' is
>>>a separate patchset.
>>>
>>>Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>>>---
>>>kernel/sysctl.c |   38 ++++++++++++++++++++++++++++----------
>>>1 files changed, 28 insertions(+), 10 deletions(-)
>>>
>>>40f7e1320c82efb6e875fc3bf44408cdfd093f21
>>>diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>>index e82726f..c2b18ef 100644
>>>--- a/kernel/sysctl.c
>>>+++ b/kernel/sysctl.c
>>>@@ -233,8 +233,8 @@ static ctl_table kern_table[] = {
>>>	{
>>>		.ctl_name	= KERN_OSTYPE,
>>>		.procname	= "ostype",
>>>-		.data		= system_utsname.sysname,
>>>-		.maxlen		= sizeof(system_utsname.sysname),
>>>+		.data		= init_uts_ns.name.sysname,
>>>+		.maxlen		= sizeof(init_uts_ns.name.sysname),
>>>		.mode		= 0444,
>>>		.proc_handler	= &proc_doutsstring,
>>>		.strategy	= &sysctl_string,
>>>@@ -242,8 +242,8 @@ static ctl_table kern_table[] = {
>>>	{
>>>		.ctl_name	= KERN_OSRELEASE,
>>>		.procname	= "osrelease",
>>>-		.data		= system_utsname.release,
>>>-		.maxlen		= sizeof(system_utsname.release),
>>>+		.data		= init_uts_ns.name.release,
>>>+		.maxlen		= sizeof(init_uts_ns.name.release),
>>>		.mode		= 0444,
>>>		.proc_handler	= &proc_doutsstring,
>>>		.strategy	= &sysctl_string,
>>>@@ -251,8 +251,8 @@ static ctl_table kern_table[] = {
>>>	{
>>>		.ctl_name	= KERN_VERSION,
>>>		.procname	= "version",
>>>-		.data		= system_utsname.version,
>>>-		.maxlen		= sizeof(system_utsname.version),
>>>+		.data		= init_uts_ns.name.version,
>>>+		.maxlen		= sizeof(init_uts_ns.name.version),
>>>		.mode		= 0444,
>>>		.proc_handler	= &proc_doutsstring,
>>>		.strategy	= &sysctl_string,
>>>@@ -260,8 +260,8 @@ static ctl_table kern_table[] = {
>>>	{
>>>		.ctl_name	= KERN_NODENAME,
>>>		.procname	= "hostname",
>>>-		.data		= system_utsname.nodename,
>>>-		.maxlen		= sizeof(system_utsname.nodename),
>>>+		.data		= init_uts_ns.name.nodename,
>>>+		.maxlen		= sizeof(init_uts_ns.name.nodename),
>>>		.mode		= 0644,
>>>		.proc_handler	= &proc_doutsstring,
>>>		.strategy	= &sysctl_string,
>>>@@ -269,8 +269,8 @@ static ctl_table kern_table[] = {
>>>	{
>>>		.ctl_name	= KERN_DOMAINNAME,
>>>		.procname	= "domainname",
>>>-		.data		= system_utsname.domainname,
>>>-		.maxlen		= sizeof(system_utsname.domainname),
>>>+		.data		= init_uts_ns.name.domainname,
>>>+		.maxlen		= sizeof(init_uts_ns.name.domainname),
>>>		.mode		= 0644,
>>>		.proc_handler	= &proc_doutsstring,
>>>		.strategy	= &sysctl_string,
>>>@@ -1619,6 +1619,24 @@ static int proc_doutsstring(ctl_table *t
>>>{
>>>	int r;
>>>
>>>+	switch (table->ctl_name) {
>>>+		case KERN_OSTYPE:
>>>+			table->data = utsname()->sysname;
>>>+			break;
>>>+		case KERN_OSRELEASE:
>>>+			table->data = utsname()->release;
>>>+			break;
>>>+		case KERN_VERSION:
>>>+			table->data = utsname()->version;
>>>+			break;
>>>+		case KERN_NODENAME:
>>>+			table->data = utsname()->nodename;
>>>+			break;
>>>+		case KERN_DOMAINNAME:
>>>+			table->data = utsname()->domainname;
>>>+			break;
>>>+	}
>>>+
>>>	if (!write) {
>>>		down_read(&uts_sem);
>>>		r=proc_dostring(table,0,filp,buffer,lenp, ppos);
>>
> 


