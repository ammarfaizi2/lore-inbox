Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUFEL6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUFEL6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 07:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUFEL6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 07:58:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14549 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261159AbUFEL6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 07:58:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: gelato-technical <gelato-technical@gelato.unsw.edu.au>,
       lkcd-devl <lkcd-devel@lists.sourceforge.net>
Cc: suparna bhattacharya <suparna@in.ibm.com>,
       Prashanth Tamraparni <prasht@in.ibm.com>, jbarnes@sgi.com,
       davidm@hpl.hp.com, vgoyal@in.ibm.com
Content-Type: text/plain
Message-Id: <1086104163.5172.58.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
Subject: Lcrash on IA64 breaks due to duplicate symbol "modules" in
	System.map
Organization: 
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2004 17:26:11 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lcrash on IA64 breaks due to the presence of multiple appearance of
symbol "modules" in System.map file. Lcrash tries to load ksyms from
dump by reading linked list of modules which starts at "modules". 

Sometimes Lcrash gets confused due to multiple presence of this symbol
and is unable to load the module symbols.

On a test system, following is the output when "modules" is grepped in
System.map. I am using 2.6.5 kernel.

**********************************************************************
a0000001007d01e8 d modules
a00000010093cab0 B modules
**********************************************************************

First one is a static declaration/definition in linux/kernel/module.c.
This is the symbol lcrash is searching for to get the starting address
of list of modules.

Second one is a global declaration appearing in
linux/arch/ia64/sn/io/sn2/module.c. I am not very sure about its usage
but it seems this is being kept to maintain a list of modules keeping
some hardware specific details.

Is it a good idea to keep the two names same? If one of these can be
renamed to resolve the lcrash problem.

Thanks
Vivek

 


  

