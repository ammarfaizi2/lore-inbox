Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUEAEHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUEAEHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 00:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUEAEHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 00:07:21 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64216 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261939AbUEAEHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 00:07:20 -0400
From: Lev Makhlis <mlev@despammed.com>
To: Michael Brown <mebrown@michaels-house.net>
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATE 2
Date: Fri, 30 Apr 2004 23:07:43 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200404302009.49576.mlev@despammed.com> <1083382335.1203.2975.camel@debian>
In-Reply-To: <1083382335.1203.2975.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405010007.43171.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 23:32, Michael Brown wrote:
> On Fri, 2004-04-30 at 19:09, Lev Makhlis wrote:
> > > +	for (fp = 0xF0000; fp < 0xFFFFF; fp += 16) {
> > > +		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> > > +		if (memcmp(table_eps->anchor, "_SM_", 4)!=0)
> > > +			continue;
> >
> > This is fine for x86 and x86_64, but for ia64 -- don't you need
> > to get the SMBIOS entry point from the EFI table?
>
> Sorry, but I am not familiar with how SMBIOS tables work on IA64
> architecture, and in fact, the DMI spec says nothing about how it
> differs on IA64, that I can see.
>
> Can you please send me a URL with this information? I have access to
> some IA64 machines. I will add this code if I have a spec.
> --
> Michael

The EFI spec is here: http://developer.intel.com/technology/efi/EFI_110.htm
(SMBIOS pointer is mentioned in section 4.3), but arch/ia64/kernel/efi*.c
already reads EFI.  You may want to look at dmidecode
(http://freshmeat.net/projects/dmidecode/), which has code to read
/proc/efi/systab (which, last I checked, itself required a patch).
In kernel space, I think you could just use efi.smbios, but I'm not an expert
on that myself.

Lev

