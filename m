Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290794AbSBFUf4>; Wed, 6 Feb 2002 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBFUfr>; Wed, 6 Feb 2002 15:35:47 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:6702 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290794AbSBFUfc> convert rfc822-to-8bit; Wed, 6 Feb 2002 15:35:32 -0500
Date: Tue, 5 Feb 2002 22:34:37 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: David Mosberger <davidm@hpl.hp.com>
cc: Christoph Hellwig <hch@caldera.de>, "David S. Miller" <davem@redhat.com>,
        <mmadore@turbolinux.com>, <linux-ia64@linuxia64.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
In-Reply-To: <15457.25770.707397.595744@napali.hpl.hp.com>
Message-ID: <20020205222530.H1707-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Feb 2002, David Mosberger wrote:

> >>>>> On Wed, 6 Feb 2002 18:10:42 +0100, Christoph Hellwig <hch@caldera.de> said:
>
>   Christoph> On Wed, Feb 06, 2002 at 12:45:03AM -0800, David S. Miller
>   Christoph> wrote:
>   >> It is not using the DMA apis correctly then, it should be using
>   >> dma_addr_t which may or may not be 64-bits on a given platform.
>
>   Christoph> When the sym2 driver is configured with
>   Christoph> SYM_CONF_DMA_ADDRESSING_MOD > 1 it uses DAC accessing and
>   Christoph> needs dma64_addr_t.  It doesn't use it when using the
>   Christoph> default addressing mode.
>
> The driver never uses the pci_dac* interface, hence it should not use
> dma64_addr_t.  If the driver needs a 64-bit wide type, u64 will do
> fine.

The driver was ready for PCI DAC months before the Linux way to do DAC was
stabilized to the current one. Given the discussion on the harmless way
the sym2 driver is using dma64_addr_t, it seems to me that this interface
may still move.

This let me think that the real problem is not the sym2 driver here, but
rather the Linux IO interfaces saga that lasts from years.

For now just replacing all occurrences (in fact only 1) of the offending
dma64 thing in sym_glue.c by the corresponding dma thing should do the
trick and close this thread as a result.

If you want to discuss about either PCI DAC under Linux or Linux-i64 arch
(that btw seems to be dead prior to have born) then, please, change the
subject of this thread.

  Gérard.

