Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWECVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWECVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWECVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:33:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10672 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751358AbWECVdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:33:25 -0400
Subject: Re: Problems with EDAC coexisting with BIOS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Small <tim@buttersideup.com>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <4459119D.10905@buttersideup.com>
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com>
	 <1145888979.29648.56.camel@localhost.localdomain>
	 <4459119D.10905@buttersideup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 03 May 2006 22:44:06 +0100
Message-Id: <1146692646.14636.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-03 at 21:25 +0100, Tim Small wrote:
> something with NMI-signalled errors, I was wondering what the problems 
> with using NMI-signalled ECC errors were?

The big problem with NMI is that it can occur *during* a PCI
configuration sequence (ie during pci_config_* functions). That means we
can't safely do some I/O, especially configuration space I/O in an NMI
handler. At best we could set a flag and catch it afterwards.

