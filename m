Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVAFMMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVAFMMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVAFMMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:12:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:37126 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262750AbVAFMMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:12:10 -0500
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
From: Arjan van de Ven <arjan@infradead.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 13:12:03 +0100
Message-Id: <1105013524.4468.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 18:05 +0530, Vivek Goyal wrote:
> 
> In my machine Adaptec SCSI controller is not managing any devices. It
> is
> a lonely controller.
> 

looks like the following is happening:
the controller wants to send an irq (probably from previous life)
then suddenly the driver gets loaded
* which registers an irq handler
* which does pci_enable_device()
and .. the irq goes through. 
the irq handler just is not yet expecting this irq, so
returns "uh dunno not mine"
the kernel then decides to disable the irq on the apic level
and then the driver DOES need an irq during init
... which never happens.




