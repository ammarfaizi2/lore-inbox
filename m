Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCEWiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCEWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:38:54 -0500
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:32268 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261378AbUCEWiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:38:52 -0500
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
x-mimeole: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: ACPI stack overflow
Date: Fri, 5 Mar 2004 16:38:50 -0600
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA2@ausx2kmpc106.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI stack overflow
Thread-Index: AcQC+5v5b95cLcibRVGuqGrYcDMSSgABhUZQ
From: Stuart_Hayes@Dell.com
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
X-OriginalArrivalTime: 05 Mar 2004 22:38:50.0646 (UTC)
 FILETIME=[A16F4B60:01C40302]
X-WSS-ID: 6C57DEF12010796-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 5 Mar 2004 Stuart_Hayes@Dell.com wrote:
> 
>> 
>> Hello...
>> 
>> I think I am getting a stack overflow when Linux is parsing the ACPI
>> tables (initializing all the devices and running all the _STA
>> methods). I am using the x86_64 architecture.  I would like to try
>> increasing the kernel stack size, but I'm not sure how to go about
>> doing this. 
>> Could someone tell me how to increase the kernel stack size?
>> (And, has anyone else seen a problem with stack overflows with ACPI?)
>> 
> 
> Please fix your mailer. In Unix/Linux, we put in a [Enter] ('\n')
> every once in awhile, usually every 79 charcters so that a line
> of text does not exceed 80 characters. We do not let some indefinite
> screen "auto-wrap".
> 
>> Thanks!
>> Stuart
>> stuart_hayes@dell.com
> 
> There have been continual changes over the years to reduce the
> amount of kernel stack that the kernel uses because kernel stack-
> space is "expensive". It needs to be changed in pages.  I think
> that if you have a stack-overflow, then you are writing poor
> kernel code. In the kernel, do not put arrays on the stack, i.e,
> in "local" space. Use kmalloc()/kfree() instead.
> 
> Basically, do not increase the stack size. It just masks problems.
> It does not make them go away. If you need more stack, you
> are doing something wrong.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.

Thanks.  Unfortunately, it isn't my code that's using so much stack 
space--it's the ACPI "driver".  It has many deep nested calls, and 
I believe each call in x86_64 is taking more stack space than it would
 in i386 because of the larger registers.  But, what I really wanted
 to do is increase the kernel size to verify that the problem is a 
stack overflow (my other tests have led me to believe so).  I wasn't 
going to propose that as a solution.

Thanks!
Stuart

