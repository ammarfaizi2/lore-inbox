Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSGSBQg>; Thu, 18 Jul 2002 21:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGSBQg>; Thu, 18 Jul 2002 21:16:36 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50473 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S315491AbSGSBQf>; Thu, 18 Jul 2002 21:16:35 -0400
Date: Thu, 18 Jul 2002 21:19:36 -0400
From: Doug Ledford <dledford@redhat.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Dale Amon <amon@vnl.com>,
       linux-kernel@vger.kernel.org, Frank Davis <fdavis@si.rr.com>
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
Message-ID: <20020718211936.C28235@redhat.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org,
	Frank Davis <fdavis@si.rr.com>
References: <20020718154533.GA6851@vnl.com> <Pine.LNX.4.44.0207181815160.29194-100000@linux-box.realnet.co.sz> <20020718210340.A28235@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020718210340.A28235@redhat.com>; from dledford@redhat.com on Thu, Jul 18, 2002 at 09:03:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There was a bug in the patch I sent through last.  This patch should be 
applied on top of the last one to solve a memory leak on unloading of the 
module.



-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="BusLogic-2.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.740   -> 1.741  
#	drivers/scsi/BusLogic.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/18	dledford@perf50.perf.redhat.com	1.741
# BusLogic.c:
#   DMA Mapping API update, part 2
# --------------------------------------------
#
diff -Nru a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
--- a/drivers/scsi/BusLogic.c	Thu Jul 18 21:18:46 2002
+++ b/drivers/scsi/BusLogic.c	Thu Jul 18 21:18:46 2002
@@ -300,6 +300,10 @@
 	  Last_CCB = CCB;
 	}
     }
+  if (Last_CCB)
+    pci_free_consistent(HostAdapter->PCI_Device,
+			Last_CCB->AllocationGroupSize, Last_CCB,
+		 	Last_CCB->AllocationGroupHead);
 }
 
 

--L6iaP+gRLNZHKoI4--
