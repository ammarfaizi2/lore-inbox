Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSGBVMB>; Tue, 2 Jul 2002 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSGBVMA>; Tue, 2 Jul 2002 17:12:00 -0400
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:2822 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S293680AbSGBVMA>; Tue, 2 Jul 2002 17:12:00 -0400
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB07243E@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: marcelo@conectiva.com.br, alan@redhat.com
cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: [PATCH] GUID Partition Tables for 2.4.x
Date: Tue, 2 Jul 2002 16:14:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 113CC83A589495-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend, pine confusion ate my From header)

Marcelo and Alan:

Posted to http://domsch.com/linux/patches/gpt is the GUID Partition Table 
code, copied from the IA64 port patch and applied to 2.4.19-pre1 and 
2.4.19-pre10-ac2.  This code is identical to that included in the IA64 
port patch already, and has been in use on IA64 for many many months.  
Equivalent code is already included in the 2.5 kernel series.  I'm 
submitting now for 2.4.x so that a partition table scheme which supports 
Large Block Devices will be available if/when Peter Chubb's work on such 
is backported from 2.5.x.  I've tested this on x86.

The work consist of two parts:
1) Changes efi_guid_t typedef to match the 2.5.x implementation.  This 
code is already included in the ia64 port patch for 2.4.x, and I have 
David Mosberger's approval to submit this directly for 2.4.x.

 arch/ia64/kernel/efivars.c |   21 +++++----------------
 arch/ia64/kernel/mca.c     |   28 +++++++++++++---------------
 include/asm-ia64/efi.h     |   36 +++++++++++++++++++++++++++---------
 include/asm-ia64/sal.h     |   36 ++++++++++++++++++------------------
 4 files changed, 63 insertions, 58 deletions


2) Adds fs/partitions/efi.[ch] and associated small changes to related 
files.  The arch/ia64/defconfig change removes a stale entry.

 Documentation/Configure.help |   11
 arch/ia64/defconfig          |    1
 fs/partitions/Config.in      |    1
 fs/partitions/Makefile       |    2
 fs/partitions/check.c        |    4
 fs/partitions/efi.c          |  804
+++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/efi.h          |  119 ++++++
 fs/partitions/msdos.c        |   11
 8 files changed, 943 insertions, 10 deletions


The patches are in both BK Changeset form and traditional diff.

BK:
http://domsch.com/linux/patches/gpt/linux-2.4-gpt-efiguidt.cset
http://domsch.com/linux/patches/gpt/linux-2.4-gpt.cset

Patch:
http://domsch.com/linux/patches/gpt/linux-2.4.19-rc1-efiguidt.patch
http://domsch.com/linux/patches/gpt/linux-2.4.19-rc1-gpt.patch


Marcelo, I understand you won't wish to apply this before 2.4.19 final.  I 
don't expect any conflicts to arise between this code and anything 
expected in 2.4.19 final, so please try to apply this after 2.4.19 is out.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)



