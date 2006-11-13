Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755300AbWKMSAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbWKMSAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbWKMSAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:00:38 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50570 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755300AbWKMSAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:00:37 -0500
Date: Mon, 13 Nov 2006 12:59:47 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061113175947.GA13832@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <200611131822.44034.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131822.44034.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 06:22:43PM +0100, Andi Kleen wrote:
[..]
> 
> > +verify_cpu:
> > +	pushl	$0			# Kill any dangerous flags
> > +	popfl
> > +
> > +	/* minimum CPUID flags for x86-64 */
> > +	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
> > +#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
> > +			   (1<<13)|(1<<15)|(1<<24)|(1<<25)|(1<<26))
> > +#define REQUIRED_MASK2 (1<<29)
> 
> It would be much better if this least this CPUID code was in a common shared 
> file with head.S

Hi Andi,

This code (verify_cpu) is called while we are still in real mode. So it has
to be present in low 1MB. Now in trampoline has been designed to switch to
64bit mode and then jump to the kernel hence kernel can be loaded anywhere
even beyond (4G). So if we move this code into say arch/x86_64/kernel/head.S
then we can't even call it.

So I think we got to leave it in trampoline only.

Thanks
Vivek
