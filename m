Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTEFOsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTEFOsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:48:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45477 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263785AbTEFOst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:48:49 -0400
Date: Tue, 06 May 2003 08:00:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 668] New: Wrong xfer_funcs initialization in drivers/block/loop.c
Message-ID: <12770000.1052233247@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=668

           Summary: Wrong xfer_funcs initialization in drivers/block/loop.c
    Kernel Version: 2.5.68 and 2.5.69 (at least)
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: Reimar.Doeffinger@stud.uni-karlsruhe.de


Distribution: SuSE Linux Professional 8.1
Software Environment: gcc 3.2.2 (but should be independant of that...)

Problem Description:
In drivers/block/loop.c loop_register_transfer always fails because all entries
(instead of only first and seond) of the xfer_funcs array (in same file) are
initialized to non-zero values (&xor_funcs).

Solution: 
Change 

struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
	&none_funcs,
	&xor_funcs  
};

to

struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
	&none_funcs,
	&xor_funcs,
	0
};

in kernel version 2.4.20 there was only a comma after &xor_funcs:

struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
	&none_funcs,
	&xor_funcs,
};

which worked as well, but I guess it's better when the code doesn't depend on a
single comma.


