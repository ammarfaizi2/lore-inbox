Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSJZAWI>; Fri, 25 Oct 2002 20:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJZAWI>; Fri, 25 Oct 2002 20:22:08 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:56557 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261733AbSJZAWF>; Fri, 25 Oct 2002 20:22:05 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70DA@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 17:26:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agree. We can calculate smp_num_siblings from phys_proc_id[n] as the kernel
does, although it would be just nice or double-checking (but if the
application cannot calculate it correctly how can one expect it runs fine? I
mean it's very easy.)

So this is sufficient:
+#ifdef CONFIG_SMP
+	if (cpu_has_ht) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+	}
+#endif

For a multi-core system, one could do:

	seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
	seq_printf(m, "core id\t: %d\n", core_id[n]);

This would support multiple SMT processor cores on one chip. "core_id" is
the id of the CPU core in a chip die that the processor belongs to.
"physical_proc_id" is the id of the CPU die in the system.

Jun
-----Original Message-----
From: Dave Jones [mailto:davej@codemonkey.org.uk]
Sent: Friday, October 25, 2002 5:13 PM
To: Jeff Garzik
Cc: Robert Love; Nakajima, Jun; Alan Cox; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo


On Fri, Oct 25, 2002 at 08:04:45PM -0400, Jeff Garzik wrote:

 > Not really... we print out other information that is duplicated N times, 
 > because it is the common case that N-way systems have matched processors 
 > with matched capabilities.

Not really. We print out the 'duplicate' info because it's read that
way from different CPUs. The smp_num_siblings is a single global
variable. Theoretically, the other stuff /could/ change in an
asymetrical system, but the num_siblings thing is constant.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
