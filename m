Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVIOMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVIOMIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVIOMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:08:50 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:916 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964866AbVIOMIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:08:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fbU7hNLJgL/24CeKURVJeOl4vZFfxAq3MxwrdG5f073wPbkck1Rer7AtZhor/I/yktDYOmxSxTu+I7GNXjLKHCfbc/oDydJzFZxeUHxJaaPEW9ohfSOdiErTWp0sE/skP6cameqxTHURA+8dYgMGGrBIis/CVuyzFqcSTSzYwd8=
Message-ID: <43296445.8040805@gmail.com>
Date: Thu, 15 Sep 2005 20:08:37 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@linuxtv.org>
CC: Ralph Metzler <rjkm@metzlerbros.de>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com>	<200509150843.33849@bilbo.math.uni-mannheim.de>	<4329269E.1060003@linuxtv.org>	<200509151018.20322@bilbo.math.uni-mannheim.de>	<4329362A.1030201@linuxtv.org> <17193.19739.213773.593444@localhost.localdomain> <43295E41.8010808@linuxtv.org>
In-Reply-To: <43295E41.8010808@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham wrote:
> Ralph Metzler wrote:
> 

>                SA_INTERRUPT, DRIVER_NAME, mantis) < 0) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
>        goto err2;
>    }
>    dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>    dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>    pci_set_master(pdev);
>    pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>    pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>    mantis->latency = latency;
>    mantis->revision = revision;
>    if (!latency) {
>        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>    }
>    pci_set_drvdata(pdev, mantis);      dprintk(verbose, MANTIS_ERROR, 0,
> "Mantis Rev %d, ", mantis->revision);
>    dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\n \
>        memory: 0x%04x, mmio: %p\n", pdev->irq, mantis->latency,    \
>        mantis->mantis_addr, mantis->mantis_mmio);

Success!  So don't enter the failure path, return 0 here.

>   err2:
>    if (mantis->mantis_mmio)
>        iounmap(mantis->mantis_mmio);
> err1:
>    release_mem_region(pci_resource_start(pdev, 0),
>                pci_resource_len(pdev, 0));
> err0:
>    kfree(mantis);
> err:
>    return 0;

This is your failure path, return nonzero here, preferable describing the
error condition.

Tony 
