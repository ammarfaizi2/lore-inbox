Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVCHMu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVCHMu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCHMu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:50:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22242 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262032AbVCHMs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:48:56 -0500
Subject: Query: Kdump: Core Image ELF Format
From: vivek goyal <vgoyal@in.ibm.com>
To: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: anderson@redhat.com, haren myneni <hbabu@us.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:20:10 +0530
Message-Id: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kdump (A kexec based crash dumping mechanism) is going to export the
kernel core image in ELF format. ELF was chosen as a format, keeping in
mind that gdb can be used for limited debugging and "Crash" can be used
for advanced debugging.

Core image ELF headers are prepared before crash and stored at a safe
place in memory. These headers are retrieved over a kexec boot and final
elf core image is prepared for analysis. 

Given the fact physical memory can be dis-contiguous, One program header
of type PT_LOAD is created for every contiguous memory chunk present in
the system. Other information like register states etc. is captured in
notes section.

Now the issue is, on i386, whether to prepare core headers in ELF32 or
ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
don't know about "crash". Can "crash" support ELF64 core image file for
i386 system?

Given the limitation of analysis tools, if core headers are prepared in
ELF32 format then how to handle PAE systems? 

Any thoughts or suggestions on this?

Thanks
Vivek

