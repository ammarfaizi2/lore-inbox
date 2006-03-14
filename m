Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCNXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCNXNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWCNXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:13:51 -0500
Received: from web26506.mail.ukl.yahoo.com ([217.146.176.43]:19316 "HELO
	web26506.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750880AbWCNXNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:13:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CPu9sBksYI4iqcQtfcTapzeqC2ynwtRw4OD92J8Kj1OJVnibttVRmgN4YtIqcSad0dIWkh8SBx+2cMv4gHTeLr4iM+9IN8HdLTUI0VcKAq1nDBJ0WpR1i6W3JorW+tfJpooix/Y26DLT8i6siVwWutB08eFIXKFTAu92E2iVsFc=  ;
Message-ID: <20060314231344.44688.qmail@web26506.mail.ukl.yahoo.com>
Date: Wed, 15 Mar 2006 00:13:44 +0100 (CET)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was:      realtime-preempt patch-2.6.15-rt18 issues)
To: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>
Cc: Jan Altenberg <tb10alj@tglx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2056123954-1142378024=:44661"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2056123954-1142378024=:44661
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline


--- Rui Nuno Capela <rncbc@rncbc.org> schrieb:
> - The SLAB related usb-storage crash on disconnect is
> still there:

and its still in up to rc6-rt3, unless you apply attached
patch. My uniprocessor behaves with it.

Ingo, what exactly needs fixing here?

cheers,
Karsten


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
--0-2056123954-1142378024=:44661
Content-Type: text/x-diff; name="drain_cpu_caches.diff"
Content-Description: 2948625469-drain_cpu_caches.diff
Content-Disposition: inline; filename="drain_cpu_caches.diff"

--- ./mm/slab.c~	2006-03-15 00:15:49.000000000 +0100
+++ ./mm/slab.c	2006-03-15 00:15:49.000000000 +0100
@@ -2169,7 +2169,7 @@
 	int node;
 
 // FIXME:
-//	smp_call_function_all_cpus(do_drain, cachep);
+	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];

--0-2056123954-1142378024=:44661--
