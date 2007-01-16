Return-Path: <linux-kernel-owner+w=401wt.eu-S1751524AbXAPRA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbXAPRA4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXAPRAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:00:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37931 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbXAPQoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:34 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 32/59] sysctl: C99 convert arch/mips/lasat/sysctl.c and remove ABI breakage.
Date: Tue, 16 Jan 2007 09:39:37 -0700
Message-Id: <11689656574092-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

While C99 converting the ctl_table initializers I realized
that the binary sysctl numbers were in conflict with the binary
values under CTL_KERN.   Including CTL_KERN KERN_VERSION as used
by glibc.  So I just removed the sysctl binary interface for these
values, as it was unsupportable.

Luckily these sysctl were inserted at the end of the
sysctl list so this bug was not visible to userspace.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/mips/lasat/sysctl.c |  145 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 1287835..c04e82f 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -302,42 +302,129 @@ extern int lasat_boot_to_service;
 #ifdef CONFIG_SYSCTL
 
 static ctl_table lasat_table[] = {
-	{LASAT_CPU_HZ, "cpu-hz", &lasat_board_info.li_cpu_hz, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_BUS_HZ, "bus-hz", &lasat_board_info.li_bus_hz, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_MODEL, "bmid", &lasat_board_info.li_bmid, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_PRID, "prid", &lasat_board_info.li_prid, sizeof(int),
-	 0644, NULL, &proc_lasat_eeprom_value, &sysctl_lasat_eeprom_value},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "cpu-hz",
+		.data		= &lasat_board_info.li_cpu_hz,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "bus-hz",
+		.data		= &lasat_board_info.li_bus_hz,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "bmid",
+		.data		= &lasat_board_info.li_bmid,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "prid",
+		.data		= &lasat_board_info.li_prid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_lasat_eeprom_value,
+		.strategy	= &sysctl_lasat_eeprom_value
+	},
 #ifdef CONFIG_INET
-	{LASAT_IPADDR, "ipaddr", &lasat_board_info.li_eeprom_info.ipaddr, sizeof(int),
-	 0644, NULL, &proc_lasat_ip, &sysctl_lasat_intvec},
-	{LASAT_NETMASK, "netmask", &lasat_board_info.li_eeprom_info.netmask, sizeof(int),
-	 0644, NULL, &proc_lasat_ip, &sysctl_lasat_intvec},
-	{LASAT_BCAST, "bcastaddr", &lasat_bcastaddr,
-		sizeof(lasat_bcastaddr), 0600, NULL,
-		&proc_dostring, &sysctl_string},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "ipaddr",
+		.data		= &lasat_board_info.li_eeprom_info.ipaddr,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_lasat_ip,
+		.strategy	= &sysctl_lasat_intvec
+	},
+	{
+		.ctl_name	= LASAT_NETMASK,
+		.procname	= "netmask",
+		.data		= &lasat_board_info.li_eeprom_info.netmask,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_lasat_ip,
+		.strategy	= &sysctl_lasat_intvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "bcastaddr",
+		.data		= &lasat_bcastaddr,
+		.maxlen		= sizeof(lasat_bcastaddr),
+		.mode		= 0600,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string
+	},
 #endif
-	{LASAT_PASSWORD, "passwd_hash", &lasat_board_info.li_eeprom_info.passwd_hash, sizeof(lasat_board_info.li_eeprom_info.passwd_hash),
-	 0600, NULL, &proc_dolasatstring, &sysctl_lasatstring},
-	{LASAT_SBOOT, "boot-service", &lasat_boot_to_service, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "passwd_hash",
+		.data		= &lasat_board_info.li_eeprom_info.passwd_hash,
+		.maxlen		= sizeof(lasat_board_info.li_eeprom_info.passwd_hash),
+		.mode		= 0600,
+		.proc_handler	= &proc_dolasatstring,
+		.strategy	= &sysctl_lasatstring
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "boot-service",
+		.data		= &lasat_boot_to_service,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec
+	},
 #ifdef CONFIG_DS1603
-	{LASAT_RTC, "rtc", &rtctmp, sizeof(int),
-	 0644, NULL, &proc_dolasatrtc, &sysctl_lasat_rtc},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "rtc",
+		.data		= &rtctmp,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dolasatrtc,
+		.strategy	= &sysctl_lasat_rtc
+	},
 #endif
-	{LASAT_NAMESTR, "namestr", &lasat_board_info.li_namestr, sizeof(lasat_board_info.li_namestr),
-	 0444, NULL, &proc_dostring, &sysctl_string},
-	{LASAT_TYPESTR, "typestr", &lasat_board_info.li_typestr, sizeof(lasat_board_info.li_typestr),
-	 0444, NULL, &proc_dostring, &sysctl_string},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "namestr",
+		.data		= &lasat_board_info.li_namestr,
+		.maxlen		= sizeof(lasat_board_info.li_namestr),
+		.mode		= 0444,
+		.proc_handler	=  &proc_dostring,
+		.strategy	= &sysctl_string
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "typestr",
+		.data		= &lasat_board_info.li_typestr,
+		.maxlen		= sizeof(lasat_board_info.li_typestr),
+		.mode		= 0444,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string
+	},
+	{}
 };
 
-#define CTL_LASAT 1	// CTL_ANY ???
 static ctl_table lasat_root_table[] = {
-	{ CTL_LASAT, "lasat", NULL, 0, 0555, lasat_table },
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "lasat",
+		.mode		=  0555,
+		.child		= lasat_table
+	},
+	{}
 };
 
 static int __init lasat_register_sysctl(void)
-- 
1.4.4.1.g278f

