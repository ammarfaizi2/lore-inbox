Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWFCCLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWFCCLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 22:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWFCCLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 22:11:01 -0400
Received: from ozlabs.org ([203.10.76.45]:14497 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932596AbWFCCLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 22:11:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.61249.962979.937698@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jun 2006 12:09:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Ravinandan Arakali <Ravinandan.Arakali@neterion.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       leonid.grossman@neterion.com, ananda.raju@neterion.com,
       rapuru.sriram@neterion.com
Subject: Re: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
In-Reply-To: <20060602145512.A13024@unix-os.sc.intel.com>
References: <Pine.GSO.4.10.10606021518500.9289-100000@guinness>
	<20060602145512.A13024@unix-os.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah writes:

> The current MSI code actually does this deliberately, not by
> accident. It's got a lot of complex code to track devices and
> vectors and make sure an enable_msi -> disable -> enable sequence
> gives a driver the same vector. It also has policies about
> reserving vectors based on potential hotplug activity etc.
> Frankly, I've never understood the need for such policies, and
> am in the process of removing all of them.

Good.  We will not be able to support a policy of giving the driver
the same vector across an enable_msi/disable/enable sequence on IBM
System p machines (64-bit PowerPC), because the firmware controls the
MSI allocation, and it doesn't give us the necessary guarantees.

Paul.
