Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCHNlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCHNlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCHNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:41:44 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:29362 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262028AbVCHNlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:41:40 -0500
Subject: Re: [PATCH][LSM/SELINUX] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: jmorris@redhat.com, chrisw@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050307161425.746e8005.akpm@osdl.org>
References: <1110220105.2778.24.camel@moss-spartans.epoch.ncsc.mil>
	 <20050307161425.746e8005.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 08 Mar 2005 08:33:56 -0500
Message-Id: <1110288836.5428.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 16:14 -0800, Andrew Morton wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > +__setup("checkreqprot=", checkreqprot_setup);
> 
> Can we have an update to Documentation/kernel-parameters.txt, please?

Ok, how does the patch below look?  Includes descriptions of the other
two SELinux-related parameters as well.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

 Documentation/kernel-parameters.txt |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+)

--- linux-2.6.11-mm2/Documentation/kernel-parameters.txt	2005-03-08 07:46:07.491966080 -0500
+++ linux-2.6.11-mm2-sel/Documentation/kernel-parameters.txt	2005-03-08 08:21:11.179157016 -0500
@@ -67,6 +67,7 @@
 	SCSI	Appropriate SCSI support is enabled.
 			A lot of drivers has their options described inside of
 			Documentation/scsi/.
+	SELINUX SELinux support is enabled.
 	SERIAL	Serial support is enabled.
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
@@ -296,6 +297,14 @@
 			See header of drivers/cdrom/cdu31a.c.
 
 	chandev=	[HW,NET] Generic channel device initialisation
+
+	checkreqprot	[SELINUX] Set initial checkreqprot flag value.
+			Format: { "0" | "1" }
+			See security/selinux/Kconfig help text.
+			0 -- check protection applied by kernel (includes any implied execute protection).
+			1 -- check protection requested by application.
+			Default value is set via a kernel config option.
+			Value can be changed at runtime via /selinux/checkreqprot.
  
  	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
 			Forces specified timesource (if avaliable) to be used
@@ -444,6 +453,14 @@
 			See Documentation/block/as-iosched.txt
 			and Documentation/block/deadline-iosched.txt for details.
 
+	enforcing	[SELINUX] Set initial enforcing status.
+			Format: {"0" | "1"}
+			See security/selinux/Kconfig help text.
+			0 -- permissive (log only, no denials).
+			1 -- enforcing (deny and log).
+			Default value is 0.
+			Value can be changed at runtime via /selinux/enforce.
+
 	es1370=		[HW,OSS]
 			Format: <lineout>[,<micbias>]
 			See also header of sound/oss/es1370.c.
@@ -1187,6 +1204,15 @@
 
 	scsi_logging=	[SCSI]
 
+	selinux		[SELINUX] Disable or enable SELinux at boot time.
+			Format: { "0" | "1" }
+			See security/selinux/Kconfig help text.
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+			If enabled at boot time, /selinux/disable can be used
+			later to disable prior to initial policy load.
+
 	serialnumber	[BUGS=IA-32]
 
 	sg_def_reserved_size=



-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

