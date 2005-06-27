Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVF0Ac2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVF0Ac2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVF0Ac1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:32:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24777 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261676AbVF0AcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:32:07 -0400
Subject: Re: [PATCH][RFC 2] char: Add Dell Systems Management Base driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       abhay_salunke@dell.com, matt_domsch@dell.com
In-Reply-To: <20050626230544.GA6121@sysman-doug.us.dell.com>
References: <20050626230544.GA6121@sysman-doug.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119832167.28649.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Jun 2005 01:29:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	/* generate SMI */
> +	asm("outb %b0,%w1" : :
> +	      "a" (ci_cmd->command_code),
> +	      "d" (ci_cmd->command_address),
> +	      "b" (command_buffer_phys_addr),
> +	      "c" (ci_cmd->signature));
> +

Is there a reason this bit is asm not an outb() macro. If its needed in
asm for the SMI behaviour then document that fact so nobody "optimises"
it.

> +	unsigned long size;
> +	int ret;

> +	size = sizeof(struct dcdbas_ioctl_hdr) + hdr.data_size;

Can this not underflow if hdr.data_size is passed in very large


There are a few others like that which look like they might need
overflow checks.

