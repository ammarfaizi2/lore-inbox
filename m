Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUHRPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUHRPxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHRPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:53:17 -0400
Received: from thunk.org ([140.239.227.29]:63136 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266919AbUHRPxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:53:15 -0400
Date: Wed, 18 Aug 2004 09:43:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, akpm@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][4/6]Register snapshotting before kexec-boot
Message-ID: <20040818134356.GA10970@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hariprasad Nellitheertha <hari@in.ibm.com>,
	linux-kernel@vger.kernel.org, fastboot@osdl.org, akpm@osdl.org,
	Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
	litke@us.ibm.com, ebiederm@xmission.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com> <20040817120911.GE3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817120911.GE3916@in.ibm.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is needed so that the kexec patches will compile on systems
that don't have APIC's enabled.

						- Ted

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 09:41:41-04:00 tytso@think.thunk.org 
#   Fix so that kexec patches compile on systems when 
#   CONFIG_X86_LOCAL_APIC is disabled.
# 
# include/asm-i386/crash_dump.h
#   2004/08/18 09:41:29-04:00 tytso@think.thunk.org +2 -0
#   Fix so that kexec patches compile on systems when 
#   CONFIG_X86_LOCAL_APIC is disabled.
# 
diff -Nru a/include/asm-i386/crash_dump.h b/include/asm-i386/crash_dump.h
--- a/include/asm-i386/crash_dump.h	2004-08-18 09:42:15 -04:00
+++ b/include/asm-i386/crash_dump.h	2004-08-18 09:42:15 -04:00
@@ -53,7 +53,9 @@
 #if defined(CONFIG_X86_IO_APIC)
 		disable_IO_APIC();
 #endif
+#if defined(CONFIG_X86_LOCAL_APIC)
 		disconnect_bsp_APIC();
+#endif
 	}
 }
 #else
