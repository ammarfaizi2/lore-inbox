Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTLIJvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTLIJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:51:09 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:33407 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264382AbTLIJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:50:40 -0500
Message-ID: <3FD59AD8.1060507@google.com>
Date: Tue, 09 Dec 2003 01:50:16 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: ACPI global lock macros
References: <3FD59441.2000202@google.com> <1070962573.5223.2.camel@laptop.fenrus.com> <3FD5990A.9020908@google.com> <20031209094356.GA19702@devserv.devel.redhat.com>
In-Reply-To: <20031209094356.GA19702@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>>maybe the odd thing is that it exists at all?
>>>(eg why does ACPI need to have it's own locking primitives...)
>>
>>Because the ACPI spec defines its own locking protocol for 
>>synchronization between the OS and the BIOS.
> 
> 
> ... which can't be written based on linux locks ?

I assume (hope!) there's already a higher-level linux lock serializing 
access to acpi_acquire_global_lock() although I've not delved deeply 
into the code. This is the lock described on p112 of 
http://www.acpi.info/DOWNLOADS/ACPIspec-2-0c.pdf, which has the 
semantics that if the OS wants to take the lock while the BIOS holds it, 
it sets a bit and waits for an interrupt from the BIOS. I don't see that 
it could be naturally implemented using a linux lock.

Paul

