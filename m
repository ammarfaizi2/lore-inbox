Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVCPBDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVCPBDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 20:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVCPBDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 20:03:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:4577 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262265AbVCPBDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 20:03:15 -0500
Message-Id: <200503160103.j2G132YO016999@death.nxdomain.ibm.com>
To: Rick Jones <rick.jones2@hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       ctindel@users.sourceforge.net, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.11] bonding: avoid tx balance for IGMP (alb/tlb mode) 
In-Reply-To: Message from Rick Jones <rick.jones2@hp.com> 
   of "Tue, 15 Mar 2005 16:52:14 PST." <4237833E.9080809@hp.com> 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.1
Date: Tue, 15 Mar 2005 17:03:01 -0800
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Jones <rick.jones2@hp.com> wrote:

><blank> treats IGMP packets the same as all other non-broadcast traffic (i.e. it
>will attempt to load balance). This switch behavior seems rather odd in an
>aggregated case, given the fact that most traffic (except broadcast packets)
>will be load balanced by the partner device. In addition, the switch (in
>theory) is suppose to treat the aggregated switch ports as 1 logical port
>and therefore it should allow IGMP packets to be received back on any port
>in the logical aggregation.
>
>IMO, the switch behavior in this case seems questionable.

	This patch only applies to the bonding balance-alb/tlb modes,
which do not require the switch to be configured for aggregation.  Since
the switch has no explicit knowledge that the links are being
aggregated, it seems reasonable for it to be confused by what it gets in
the described case.

	I haven't tested the patch, but conceptually the problem John
described in his original mail sounds plausible, as does the fix for it.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com

