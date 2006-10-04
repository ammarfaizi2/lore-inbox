Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWJDElw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWJDElw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWJDElw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:41:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42185 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030278AbWJDElv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:41:51 -0400
Message-ID: <45233B58.1050208@zytor.com>
Date: Tue, 03 Oct 2006 21:40:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com>
In-Reply-To: <20061004042850.GA27149@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> 
> Hi Andrew,
> 
> Right now I don't have access to my test machine.  Tomorrow morning,
> very first thing I am going to try it out with your config file.
> 
> This patch just adds and ELF header to bzImage which is not even used
> by grub.
> 

Oh yes, it will be.  See below.

> So without this patch you are able to boot the kernel on your laptop?

Danger, Will Robinson.  GRUB, Etherboot, and a whole bunch of other boot 
loaders will recognize an ELF binary and load it as such.  They will 
typically load it as an executable (not a relocatable object) -- I doubt 
many of them check that appropriate part of the ELF header -- so unless 
your kernel can be safely loaded *AND RUN* in that mode this is not 
going to work.

The entrypoint is going to be a major headache, since the standard 
kernel is entered in real mode, whereas an ELF file will typically be 
entered in protected mode, quite possibly using the C calling convention 
to pass the command line as (argc, argv).  God only knows how they're 
going to deal with an initrd.

It may very well be that the ELF magic number has to be obfuscated.

	-hpa
