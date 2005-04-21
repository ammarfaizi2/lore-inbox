Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDURzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDURzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVDURzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:55:12 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:27531 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261585AbVDURyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:54:47 -0400
Message-ID: <4267E8DF.9070101@mesatop.com>
Date: Thu, 21 Apr 2005 11:54:39 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc3 compile error in aic7xxx_osm.c
References: <779170000.1114105182@flay>
In-Reply-To: <779170000.1114105182@flay>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_init':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:3608: parse error before `int'
> drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: `rc' undeclared (first use in this function)
> drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: (Each undeclared identifier is reported only once
> drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: for each function it appears in.)
> drivers/scsi/aic7xxx/aic7xxx_osm.c: At top level:
> drivers/scsi/aic7xxx/aic7xxx_osm.c:744: warning: `ahc_linux_detect' defined but not used
> 
> 

Looks fixed in Linus' current tree:
--------------------------
commit 858eaca169ed5e7b1b14eebb889323e75a02af0e
tree 385e241e0cc18794b8d8b70095181e2578bee14c
parent a2755a80f40e5794ddc20e00f781af9d6320fafb
author James Bottomley <James.Bottomley@SteelEye.com> Thu, 21 Apr 2005 21:35:45 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Thu, 21 Apr 2005 21:35:45 -0700

[PATCH] Fix aic7xxx_osm.c compile with older gcc's

My version of gcc doesn't warn about this error (declaration in the
middle of a set of statements).

The fix is simple (this also corrects return code; for init functions it
should be zero or error).


--------------------------

Steven
