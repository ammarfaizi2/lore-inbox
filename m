Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWJYOPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWJYOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWJYOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:15:24 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:29827 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1030459AbWJYOPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:15:23 -0400
To: David Miller <davem@davemloft.net>
Cc: matthew@wil.cx, jeff@garzik.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, johnip@sgi.com
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <20061024214724.GS25210@parisc-linux.org>
	<adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org>
	<20061024.154347.77057163.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 25 Oct 2006 07:15:16 -0700
In-Reply-To: <20061024.154347.77057163.davem@davemloft.net> (David Miller's message of "Tue, 24 Oct 2006 15:43:47 -0700 (PDT)")
Message-ID: <aday7r4a3d7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Oct 2006 14:15:16.0815 (UTC) FILETIME=[FECD8DF0:01C6F83F]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > One thing is that we definitely don't want to fix this by,
 > for example, reading back the PCI_COMMAND register or something
 > like that.  That causes two problems:
 > 
 > 1) Some PCI config writes shut the device down and make it
 >    no respond to some kinds of PCI config transactions.
 >    One example is putting the device into D3 or similar
 >    power state, another is performing a device reset.

Hmm... it seems there is no other guaranteed way to make sure a config
write has really completed except doing a config read.  And only the
driver knows what the config access it's doing means.  So the
conclusion we seem to be forced into is that drivers need to include
these reads in the cases where they are needed.

 - R.
