Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWDXOPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWDXOPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWDXOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:15:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:19364 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750727AbWDXOPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:15:52 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="26942862:sNHT74946585"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Mon, 24 Apr 2006 22:15:44 +0800
Message-ID: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnp+lcZld1TJoMRIO1UKkGJqHL+QAAJQ9w
From: "Ong, Soo Keong" <soo.keong.ong@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Gross, Mark" <mark.gross@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 24 Apr 2006 14:15:46.0926 (UTC) FILETIME=[94BE20E0:01C667A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To me, periodical is not a good design for error handling, it wastes
transaction bandwidth that should be used for other more productive
purposes.

It is more appropriate to have single handler, either OS or BIOS.

In general, the errors handler connect the errors to the interrupt or
interrutps. The handler should undhide (if it s hideable) the error
controller and read its registers upon interrupt, then carry out
appropriate actions to handle the erros.


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, April 24, 2006 10:14 PM
To: Ong, Soo Keong
Cc: Gross, Mark; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
Steven; Wang, Zhenyu Z
Subject: RE: Problems with EDAC coexisting with BIOS

On Llu, 2006-04-24 at 21:59 +0800, Ong, Soo Keong wrote:
> Alan,
> 
> Have you understood how the errors are connected to the interrupts
> (either SMI, NMI, SCI)?

I believe so

> When does EDAC read the error status? Periodical or upon interrpt by
> errors?

Periodically currently. The sf development tree has some code for
handling the NMI case but this isn't actually useful because an NMI can
occur half way through a PCI config transaction.

Alan
