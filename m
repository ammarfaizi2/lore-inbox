Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136630AbREAPfb>; Tue, 1 May 2001 11:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136634AbREAPfV>; Tue, 1 May 2001 11:35:21 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:44811 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S136630AbREAPfE>; Tue, 1 May 2001 11:35:04 -0400
To: Brian Gerst <bgerst@didntduck.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com>
Date: Tue, 1 May 2001 11:27:31 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/01/2001 11:30:50 AM,
	Serialize complete at 05/01/2001 11:30:50 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>mike_phillips@urscorp.com wrote:
>> 
>> To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the
>> isa_read/write's have to be changed to regular read/write due to the 
lack
>> of the isa_read/write functions for ppc.

> Treat it like a PCI device and use ioremap().  Then change isa_readl()
> to readl() etc.

Bleurgh, the latest version of the driver (not in the kernel yet) searches 
for turbo based cards by checking the isa address space from 0xc0000 - 
0xe0000 in 8k chunks. So we'd have to ioremap each 8k section, check it, 
find out the adapter isn't there and then iounmap it. 

Oh well, if that's what it takes =:0

Mike

