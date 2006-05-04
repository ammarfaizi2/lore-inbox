Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWEDQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWEDQov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWEDQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:44:51 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:23442 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1030229AbWEDQou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:44:50 -0400
Date: Thu, 04 May 2006 09:44:27 -0700
From: David Peterson <peterson66@llnl.gov>
Subject: Re: Problems with EDAC coexisting with BIOS
To: Tim Small <tim@buttersideup.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Message-id: <649b9679b6.679b6649b9@llnl.gov>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.1 Patch 1 (built Jun  6 2002)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My first thought was to schedule a tasklet as part of the ECC-
specific 
> NMI handling, or are there any gotchas with doing this from within 
> an NMI handler?

Unfortunately yes.  __tasklet_schedule() uses interrupt disabling
as a synchronization mechanism.  This presents a problem since by
definition, NMIs can occur even when interrupts are disabled. 
However the NMI handling code in bluesmoke has a mechanism similar to
tasklets that is intended specifically for use by NMI handlers.


