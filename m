Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWCASuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWCASuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWCASuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:50:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750929AbWCASuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:50:02 -0500
Date: Wed, 1 Mar 2006 10:48:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com, ashok.raj@intel.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301104822.622fe6c3.akpm@osdl.org>
In-Reply-To: <20060301101419.A30674@unix-os.sc.intel.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<20060301032527.1b79fc7c.akpm@osdl.org>
	<20060301101419.A30674@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> On Wed, Mar 01, 2006 at 03:25:27AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > If you have (even more) time you could test
> > >  http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
> > 
> > err, don't enable CONFIG_ACPI_HOTPLUG_CPU.
> > 
> > Ashok, x86_64 and i386 share a lot of code.  Please always perform good
> > regression testing against one when developing for the other.
> > 
> > arch/i386/kernel/acpi/boot.c: In function `acpi_unmap_lsapic':
> > arch/i386/kernel/acpi/boot.c:583: `num_processors' undeclared (first use in this function)
> 
> ...
>
> Need to make "num_processors" non-static since we need in acpi_unmap_lsapic
> shared function in arch/i386/kernel/acpi/boot.c. Also needs to be __cpuinitdata
> now.
> 
> ...
>
> -static unsigned int __devinitdata num_processors;
> +unsigned int __cpuinitdata num_processors;

We'll need more than that - the compile failed due to a missing declaration.

