Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWAWOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWAWOTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAWOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:19:04 -0500
Received: from mx1.suse.de ([195.135.220.2]:21670 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751279AbWAWOTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:19:03 -0500
From: Andi Kleen <ak@suse.de>
To: Dan Aloni <da-x@monatomic.org>
Subject: Re: [PATCH] x86_64: Remove useless KDB vector
Date: Mon, 23 Jan 2006 15:18:52 +0100
User-Agent: KMail/1.8.2
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>
References: <20060123135551.GA14271@localdomain>
In-Reply-To: <20060123135551.GA14271@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231518.53190.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 14:55, Dan Aloni wrote:
> > It was set as an NMI, but the NMI bit always forces an interrupt
> > to end up at vector 2. So it was never used. Remove.
> 
> So with this function removed, what is the proper fix for using 
> the kdb x86_64 patch (forward-ported from 2.6.14) on 2.6.16-rc1?
> Can I expect it to work properly if I just remove the function 
> call?

Add this code snippet to arch/x86_64/kdb/kdbasupport.c

#include <asm/mach_apic.h>
#include <asm/hw_irq.h>
void smp_kdb_stop(void)
{
       send_IPI_allbutself(NMI_VECTOR);
}


-Andi
