Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUDFJwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbUDFJwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:52:46 -0400
Received: from scilla.di.uniba.it ([193.204.187.135]:58082 "HELO
	scilla.di.uniba.it") by vger.kernel.org with SMTP id S263743AbUDFJwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:52:44 -0400
Date: Tue, 6 Apr 2004 11:51:49 +0200
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Jan Killius <jkillius@arcor.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Oops with cpufreq on 2.6.5-mm1
Message-Id: <20040406115149.6fc6edf8.buffer@antifork.org>
In-Reply-To: <20040406000500.GA26760@gate.unimatrix>
References: <20040406000500.GA26760@gate.unimatrix>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004 02:05:00 +0200
Jan Killius <jkillius@arcor.de> wrote:

>Hi,
>cpufreq make an Oops on loading. I have attached the oops.

The problem seems to be located in find_psb_table(). In fact, 
while powernow_table is correctly initialized, it's never assigned
to data->powernow_table thus leading to a NULL pointer dereferencing
in cpufreq_frequency_table_cpuinfo(). Try this patch please.

Regards.

--

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org


--- linux-2.6.5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2004-04-06 11:46:41.000000000 +0200
+++ linux-2.6.5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-04-06 11:48:29.000000000 +0200
@@ -634,6 +634,8 @@
 			return -EIO;
 		}
 
+		data->powernow_table = powernow_table;
+
 		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
 		       data->currfid, find_freq_from_fid(data->currfid), data->currvid);
 



