Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263910AbTJFAPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTJFAPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:15:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263910AbTJFAPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:15:13 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Dynamic irq_vector allocation for 2.6.0-test6-mm
Date: Sun, 5 Oct 2003 17:14:31 -0700
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200310031807.20650.jamesclv@us.ibm.com> <Pine.LNX.4.53.0310040016490.18935@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310040016490.18935@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310051714.31044.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 October 2003 9:18 pm, Zwane Mwaikambo wrote:
> On Fri, 3 Oct 2003, James Cleverdon wrote:
> > irq_vector is indexed by a value that can be as large as the sum of all
> > the RTEs in all the I/O APICs.  On a 32-way x445 or a 16-way x440 with
> > PCI expansion boxes, the static array will overflow.
>
> What is number of interrupt sources on that 32x?

That depends on the number of PCI cards plugged into the slots and how many of 
the four interrupt lines (/INTA - /INTD) are used.

However it doesn't matter.  Even if no cards are present, the array will still 
overflow because the I/O APIC init routines assign a vector to each RTE and 
run off the end of irq_vector.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
