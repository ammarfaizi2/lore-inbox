Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULJSjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULJSjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbULJSjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:39:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:31901 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261794AbULJSjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:39:10 -0500
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Kylene Hall <kjhall@us.ibm.com>
To: Ian Campbell <icampbell@arcom.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102693298.31305.98.camel@icampbell-debian>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102676169.31305.85.camel@icampbell-debian>
	 <1102692480.20230.3.camel@jo.austin.ibm.com>
	 <1102693298.31305.98.camel@icampbell-debian>
Content-Type: text/plain
Message-Id: <1102703942.20230.13.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Dec 2004 12:39:03 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 09:41, Ian Campbell wrote:
> On Fri, 2004-12-10 at 09:28 -0600, Kylene Hall wrote:
> > Good point.  Splitting this out (esp. because there will be more in the
> > future) is a good idea.  What is the usual way to do this?  For example,
> > what function in the chip specific file would call
> > register_tpm_hardware, how do I make sure that gets called etc.
> 
> I guess you could have multiple modules, one providing the generic code
> and the dev interface etc (tpm.ko) and then one per hardware chip
> (tmp-nsc.ko, tpm-atmel.ko, tpm-atmel-i2c.ko). 
> 
> The hardware modules can then call tpm_register_hardware() in their
> module_init function. 
> 
I have begun to implement it this but the problem I have now is that
this setup makes tpm_atmel and tpm_nsc dependent on tpm.  Since tpm
calls pci_register_driver in its init (which has to happen before
tpm_<specific> init) probe is called before the "interfaces" are
registered and thus the tpm_probe fails to find the device.  Do I move
the pci_register?  If so what is the proper place to register it? When
one interface registers?  If so then I think devices for the second and
subsequent interfaces would never be discovered for the same reason as I
am currently experiencing.  Do I need to move the current tpm probe
logic to the hw specific drivers?

Thanks,
Kylene


> Ian.

