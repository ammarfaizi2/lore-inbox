Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTKZIo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 03:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTKZIo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 03:44:57 -0500
Received: from catv-d5dea83f.bp11catv.broadband.hu ([213.222.168.63]:9738 "EHLO
	balabit.hu") by vger.kernel.org with ESMTP id S263984AbTKZIoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 03:44:55 -0500
Date: Wed, 26 Nov 2003 09:44:51 +0100
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [PATCH] fix for crash for invalid MP table
Message-ID: <20031126084451.GA538@balabit.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

Attached you will find a patch which changes a couple of 'panic' calls to
'printk' in the MP table parsing code. The problem is that panics so early
in the boot process cause nothing to be printed on the console, my laptop
froze immediately after printing "Uncompressing Linux..."

Changing the panics to printks solved the problem here, the kernel displays
an error message but then continues to boot. I can finally use the lapic
with this patch in place.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="printk-insteadofpanic.diff"

--- linux-2.6.0-test9/arch/i386/kernel/mpparse.c	Wed Nov 26 09:36:27 2003
+++ linux-2.6.0-test9/arch/i386/kernel/mpparse.c	Wed Nov 26 09:31:49 2003
@@ -361,7 +361,7 @@
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
-		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
+		printk("SMP mptable: bad signature [%c%c%c%c]!\n",
 			mpc->mpc_signature[0],
 			mpc->mpc_signature[1],
 			mpc->mpc_signature[2],
@@ -369,7 +369,7 @@
 		return 0;
 	}
 	if (mpf_checksum((unsigned char *)mpc,mpc->mpc_length)) {
-		panic("SMP mptable: checksum error!\n");
+		printk("SMP mptable: checksum error!\n");
 		return 0;
 	}
 	if (mpc->mpc_spec!=0x01 && mpc->mpc_spec!=0x04) {

--zYM0uCDKw75PZbzx--


