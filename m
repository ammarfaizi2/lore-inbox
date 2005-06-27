Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVF0B56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVF0B56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVF0B56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 21:57:58 -0400
Received: from quark.didntduck.org ([69.55.226.66]:33255 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261705AbVF0Bx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 21:53:28 -0400
Message-ID: <42BF5C1C.9080409@didntduck.org>
Date: Sun, 26 Jun 2005 21:53:32 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Doug Warzecha <Douglas_Warzecha@dell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       abhay_salunke@dell.com, matt_domsch@dell.com
Subject: Re: [PATCH][RFC 2] char: Add Dell Systems Management Base driver
References: <20050626230544.GA6121@sysman-doug.us.dell.com> <1119832167.28649.55.camel@localhost.localdomain>
In-Reply-To: <1119832167.28649.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>+
>>+	/* generate SMI */
>>+	asm("outb %b0,%w1" : :
>>+	      "a" (ci_cmd->command_code),
>>+	      "d" (ci_cmd->command_address),
>>+	      "b" (command_buffer_phys_addr),
>>+	      "c" (ci_cmd->signature));
>>+
> 
> 
> Is there a reason this bit is asm not an outb() macro. If its needed in
> asm for the SMI behaviour then document that fact so nobody "optimises"
> it.
> 

Because it has to load values into %ebx and %ecx for the SMI call.  The 
macro doesn't allow for that.

--
				Brian Gerst


