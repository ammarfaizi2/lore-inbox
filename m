Return-Path: <linux-kernel-owner+w=401wt.eu-S1750919AbXAHV1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXAHV1M (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbXAHV1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:27:12 -0500
Received: from outbound-mail-55.bluehost.com ([69.89.20.35]:48581 "HELO
	outbound-mail-55.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750919AbXAHV1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:27:11 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] update MMConfig patches w/915 support
Date: Mon, 8 Jan 2007 13:27:15 -0800
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org> <200701071144.16045.jbarnes@virtuousgeek.org> <20070108204520.GB15481@dspnet.fr.eu.org>
In-Reply-To: <20070108204520.GB15481@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081327.16019.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 8, 2007 12:45 pm, Olivier Galibert wrote:
> On Sun, Jan 07, 2007 at 11:44:16AM -0800, Jesse Barnes wrote:
> > For reference, here's the probe routine I tried for 965, probably
> > something dumb wrong with it that I'm not seeing atm.
>
> It shouldn't have mattered in your case, but base_address is limited
> to 32bits.  There is a 32 bits reserved zone after it so hope is not
> to be lost, but in any case the current code can't handle over-4G
> base addresses at that point.
>
> Does the bios or your '965 give a correct acpi mmconfig entry?

I should have captured the debug printk I put in while testing.  I think 
the base address specified in the register was 0xf0000000, with a size 
of 256M marked enabled.  Arjan points out that this likely conflicts 
with other BIOS mappings, which is probably why I saw my machine hang 
when I tried to use it.

As for ACPI, I assume you mean the MCFG table?  I haven't looked at it, 
but the stock kernel complains about a lack of the MCFG range in the 
e820 table and subsequently disables mmconfig.

But won't the bridge register value control what actually gets decoded?  
If so, it sounds like this BIOS is buggy wrt mmconfig mapping in 
general; good thing I'm not using any PCIe devices I guess...

Thanks,
Jesse
