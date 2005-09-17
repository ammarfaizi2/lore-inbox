Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbVIQH7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVIQH7r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVIQH7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:59:47 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:29865 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751003AbVIQH7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:59:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sPZwqUx8GNt3vc9VQQH+NzHW823y+8W+QAQvIemGPzxqc1mnWb/tSZ58fAzJJQdv1ecciKcuM61nXU2rHgIXK73tTWKi25k63DtAma9Rx8YnJeS84NAb3h65es1eBQjMYxotxgT1botfK0JQqLeAXAfcY8riF6fZvXgELZsQkqY=
Date: Sat, 17 Sep 2005 12:10:07 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arnd Bergmann <arndb@de.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: ppc64: BPA iommu fails to build (BUILD_BUG_ON)
Message-ID: <20050917081006.GA18713@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a patch to make BUILD_BUG_ON error at compile-time went in
2.6.14-git1, arch/ppc64/kernel/bpa_iommu.c fails to build:

  CC      arch/ppc64/kernel/bpa_iommu.o
arch/ppc64/kernel/bpa_iommu.c: In function `get_iost_entry':
arch/ppc64/kernel/bpa_iommu.c:102: error: size of array `type name' is negative

static inline __attribute__((always_inline)) ioste get_iost_entry(unsigned long iopt_base, unsigned long io_address, unsigned page_size)
{
	unsigned long ps;
	unsigned long iostep;
	unsigned long nnpt;
	unsigned long shift;

	switch (page_size) {
	case 0x1000000:
	     ^^^^^^^^^
		ps = IOST_PS_16M;
		nnpt = 0;
		shift = 5;
		break;
	...
	default: 
		((void)sizeof(char[1 - 2*!!(1)]));
		break;

ioste = get_iost_entry(0x10000000000ul, address, 0x1000000);
						 ^^^^^^^^^

gcc is powerpc64-unknown-linux-gnu-gcc (GCC) 3.4.4 (Gentoo 3.4.4-r1)

