Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTEKVZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 17:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTEKVZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 17:25:32 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12747 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261250AbTEKVZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:25:30 -0400
Date: Sun, 11 May 2003 12:23:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 702] New: EXPORT_SYMBOL and depmod don't work well together with GCC 3.2.2
Message-ID: <16180000.1052681034@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=702

           Summary: EXPORT_SYMBOL and depmod don't work well together with
                    GCC 3.2.2
    Kernel Version: 2.5.67
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: gmmapowell@yahoo.com


Distribution: Redhat, modified
Hardware Environment: i386
Software Environment: GCC 3.2.2, modutils 2.4.25
Problem Description:

Disclaimer: as noted above, I'm using gcc 3.2.2, which isn't the top
recommendation, and I think that's the immediate cause of the problem, but I
think nevertheless GCC 3.2.2 has it right, and we're currently relying on a bug.

When I build modules and pass them to depmod, it gives me a bevy of unresolved
symbols which are found in other modules.  When I do an nm on them, I get
something like the following:

00000028 ? __ksymtab_NS8390_init
00000008 ? __ksymtab_ei_close
00000010 ? __ksymtab_ei_interrupt
00000000 ? __ksymtab_ei_open
00000018 ? __ksymtab_ei_tx_timeout
00000020 ? __ksymtab_ethdev_init

When depmod comes across these, it does not accept them because of the line 

if (objsym->secidx == ksymtab &&
    ELFW(ST_BIND)(objsym->info) == STB_GLOBAL)

and these symbols _aren't_ global because in the header file linux/module.h they
are defined as static.

