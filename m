Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWGKGEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWGKGEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGKGEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:04:48 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:47493 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S932476AbWGKGEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:04:47 -0400
Subject: [PATCH 0/4] stack overflow safe kdump (2.6.18-rc1-i386) try#2
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
Date: Tue, 11 Jul 2006 15:04:44 +0900
Message-Id: <1152597884.2414.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to incorporate all the ideas received after the previous post
(thank you!). In particular I hope the new code is handling the Voyager
case properly.

---

This is a the first of a series of patch-sets aiming at making kdump
more robust against stack overflows.

This patch set does the following:

* Add safe_smp_processor_id function to i386 architecture (this function
was inspired by the x86_64 function of the same name).

* Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

List of patches (the last two should be applied in the order of
appearance):

[1/4] safe_smp_processor_id: stack overflow safe implementation of
smp_processor_id.

[2/4] safe_smp_processor_id_voyager: stack overflow safe implementation
of smp_processor_id for i386-voyager.

[3/4] crash_use_safe_smp_processor_id: replace smp_processor_id with
safe_smp_processor_id in "arch/i386/kernel/crash.c".

[4/4] safe_smp_send_nmi_allbutself: re-implement smp_send_nmi_allbutself
so that calls to smp_processor_id (through send_IPI_allbutself) can be
replaced with safe_smp_processor_id without affecting other parts of the
kernel (as suggested by Eric Biederman).

I am looking forward to your comments and suggestions.

Regards,

Fernando

