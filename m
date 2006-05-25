Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWEYCM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWEYCM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWEYCM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:12:56 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:37355 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S964850AbWEYCMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:12:55 -0400
Subject: Re: [PATCH 02/03] kexec: Avoid overwriting the current pgd (V2,
	i386)
From: Magnus Damm <magnus@valinux.co.jp>
To: vgoyal@in.ibm.com
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
In-Reply-To: <20060524225845.GB23291@in.ibm.com>
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044242.14219.50618.sendpatchset@cherry.local>
	 <20060524225845.GB23291@in.ibm.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:14:58 +0900
Message-Id: <1148523298.5793.103.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 18:58 -0400, Vivek Goyal wrote:
> On Wed, May 24, 2006 at 01:40:41PM +0900, Magnus Damm wrote:
> >  
> > @@ -170,45 +151,16 @@ void machine_kexec_cleanup(struct kimage
> >  NORET_TYPE void machine_kexec(struct kimage *image)
> >  {
> >  	unsigned long page_list;
> > -	unsigned long reboot_code_buffer;
> > -
> > +	unsigned long control_code;
> > +	unsigned long page_table_a;
> >  	relocate_new_kernel_t rnk;
> >  
> > -	/* Interrupts aren't acceptable while we reboot */
> > -	local_irq_disable();
> 
> Why are you getting rid of this call? Looks sane to disable interrupts
> early.

It made sense to disable interrupts early because we used to setup the
segments and overwrite the page tables from the c code. My patch moves
the segment handling and page table switching code into the assembly
routine, and one of the first things the assembly code does is:

	/* zero out flags, and disable interrupts */
	pushl $0
	popfl

So I think we should be safe. Thanks for checking!

/ magnus

