Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268910AbTGJE2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268912AbTGJE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 00:28:20 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:21775 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S268910AbTGJE2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 00:28:19 -0400
Date: Thu, 10 Jul 2003 14:42:44 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jim Keniston <jkenisto@us.ibm.com>
cc: LKML <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Randy Dunlap <rddunlap@osdl.org>
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
In-Reply-To: <3F0AFFE6.E85FF283@us.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307101419080.15602-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jim Keniston wrote:

+       kerror_nl = netlink_kernel_create(NETLINK_KERROR, kerror_netlink_rcv);
+       if (kerror_nl == NULL)
+               panic("kerror_init: cannot initialize kerror_nl\n");

You can simply use NULL instead of passing the dummy kerror_netlink_rcv
function.

+struct kern_log_entry {
+       __u16   log_kmagic;     /* always LOGREC_KMAGIC */
+       __u16   log_kversion;   /* which version of this struct? */
+       char    log_facility[FACILITY_MAXLEN];  /* e.g., driver name */

These fields should generally be specified in ascending order to help with 
alignment.

It may also be worth looking at how the ULOG code batches messages to 
improve peformance.




- James
-- 
James Morris
<jmorris@intercode.com.au>




