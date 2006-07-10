Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWGJHt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWGJHt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWGJHt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:49:58 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:54505 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751280AbWGJHt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:49:57 -0400
Subject: [PATCH 0/3] stack overflow safe kdump (2.6.18-rc1-i386)
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Mon, 10 Jul 2006 16:49:37 +0900
Message-Id: <1152517777.2120.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a the first of a series of patch-sets aiming at making kdump
more robust against stack overflows.

This patch set does the following:

* Add safe_smp_processor_id function to i386 architecture (this function
was inspired by the x86_64 function of the same name).

* Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

List of patches (the last two should be applied in the order of
appearance):

[1/5] safe_smp_processor_id: stack overflow safe implementation of
smp_processor_id.

[2/5] crash_use_safe_smp_processor_id: replace smp_processor_id with
safe_smp_processor_id in "arch/i386/kernel/crash.c".

[3/5] ipi_use_safe_smp_processor_idfault: replace smp_processor_id with
safe_smp_processor_id in "include/asm-i386/mach-*/mach_ipi.h".

I tried to incorporate all the ideas received after a previous post. In
particular I hope the new code is handling the Voyager case properly.

I am looking forward to your comments and suggestions.

Regards,

Fernando

