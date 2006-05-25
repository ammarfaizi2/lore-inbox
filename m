Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWEYKbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWEYKbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWEYKbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:31:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32055 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965111AbWEYKbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:31:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=GfKpe/XB2a9Ez7tjH4VN+4C5KPOVwoqNr7OVCh84OWxRE5Sea8Eipi84fQuhHG3v/Hyq/NTdokZNZaD91oYnhbXAWBA9kUbTmgUBSSw6S4wnOxtwVblOVLwa5P5TflZ227DwIWD2jR0lbVcOEe+ZNx8QKbBUXazjKrP5NJI13sQ=
Message-ID: <4475879B.6030003@gmail.com>
Date: Thu, 25 May 2006 12:31:32 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com> <44758683.4070205@garzik.org>
In-Reply-To: <44758683.4070205@garzik.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik napsal(a):
> Jiri Slaby wrote:
>>>> +unprobe:
>>>> +    for (j = i; j > 0; j--) {
>>>> +        struct gt96100_if_t *gtif = &gtifs[j - 1];
>>>> +        gt96100_remove1(gtif);
>>>> +    }
>>>> +    kfree(gtifs);
>>> upon failure, you fail to set drvdata back to NULL
>> What is the purpose of setting this to NULL, other drivers don't do
>> that too?
> 
> A simple grep(1) shows well over 300 cases that do this.
But also shows the latter case: some of them do not have pci_dev_setdrv([^,]*,
NULL) -- it finds only one occurence of that function (that set the value).
> 
> And it's just logical:  don't leave a pointer hanging around, after it
> has been kfree'd.
Seems logical. Will do it.

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
