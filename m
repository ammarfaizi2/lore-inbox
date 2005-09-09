Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVIIKql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVIIKql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVIIKql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:46:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:42142 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030230AbVIIKqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:46:40 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm2
Date: Fri, 9 Sep 2005 12:46:34 +0200
User-Agent: KMail/1.8
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org> <20050909003947.GE19913@wotan.suse.de> <20050909034153.51203f9e.akpm@osdl.org>
In-Reply-To: <20050909034153.51203f9e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091246.35337.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 12:41, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >  > arch/x86_64/pci/built-in.o(.init.text+0xa88): In function 
`pci_acpi_scan_root':
> >  > : undefined reference to `pxm_to_node'
> >  >
> >  > make: *** [.tmp_vmlinux1] Error 1
> >  > 09/08/05-06:52:31 Build the kernel. Failed rc = 2
> >  > 09/08/05-06:52:31 build: kernel build Failed rc = 1
> >  > 09/08/05-06:52:31 command complete: (2) rc=126
> >  > Failed and terminated the run
> >
> >  I tried the config in my (non mm) tree and it compiled just fine.
>
> You must have mucked it up.

Martin put up the wrong .config. I fixed it now in my tree.
The problem was that he didn't enable ACPI_NUMA, just NUMA
and the acpi.c code only checked _NUMA

>
>
> Also, x86_64-srat-overlap-error.patch adds this forward decl in
> arch/x86_64/mm/srat.c:
>
> int node_to_pxm(int n);
>
> Please, either give it static scope or, if it really needs global scope (it
> doesn't), put the declaration in the right place?

I'll make it static.

-Andi

