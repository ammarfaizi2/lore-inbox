Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWJDPTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWJDPTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWJDPTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:19:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31180 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161231AbWJDPTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:19:07 -0400
Message-ID: <4523D0AF.5000907@zytor.com>
Date: Wed, 04 Oct 2006 08:18:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org>	<20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <m1sli4cxr2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1sli4cxr2.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>> The entrypoint is going to be a major headache, since the standard kernel is
>> entered in real mode, whereas an ELF file will typically be entered in protected
>> mode, quite possibly using the C calling convention to pass the command line as
>> (argc, argv).  God only knows how they're going to deal with an initrd.
>>
>> It may very well be that the ELF magic number has to be obfuscated.
> 
> The entry point that is exported is the kernels protected mode entry point
> that is used after the real mode code has been run.  This is to allow
> bootloaders like kexec where running the real-mode code is insane or
> impossible to be used.  
> 
> The calling conventions though are not changed, this is just formalizing
> something that various groups have been doing for years.  Since it is
> all in the bzImage we still only have a single file format to support,
> so any bootloader that can load a standard bzImage and run the kernels
> real mode code should still do it that way but.  If you can't the
> rest of the information is available.
> 

Well, it doesn't help if what you end up with for some bootloader is a 
nonfunctioning kernel.

	-hpa
