Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266106AbSKTNaE>; Wed, 20 Nov 2002 08:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKTNaE>; Wed, 20 Nov 2002 08:30:04 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:1804 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266106AbSKTNaD>; Wed, 20 Nov 2002 08:30:03 -0500
Date: Wed, 20 Nov 2002 16:36:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Dave Olien <dmo@osdl.org>
Cc: "T. Weyergraf" <kirk@colinet.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960, 2.4.19 alpha problems
Message-ID: <20021120163619.A21996@jurassic.park.msu.ru>
References: <1037710684.11541.8.camel@irongate.swansea.linux.org.uk> <kirk-1021119132330.A0216470@hydra.colinet.de> <20021119113731.A8238@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021119113731.A8238@acpi.pdx.osdl.net>; from dmo@osdl.org on Tue, Nov 19, 2002 at 11:37:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:37:31AM -0800, Dave Olien wrote:
> On ia32, we know that the memory allocated for memory mailboxes
> (using __get_free_pages()) will always be below 4-gig.

That was it, I guess.
virt_to_bus() is deprecated - driver *must* be converted
to the DMA mapping interface (see Documentation/DMA-mapping.txt).

virt_to_bus() on alpha works only for limited range of kernel addresses.
On dp264 valid range is 0x00000000-0x7fefffff (i.e. 2Gb - 1Mb).
Given the fact that __get_free_pages() returns highest possible
pages I'm not surprised that this driver doesn't work on a 2Gb machine.

Probably "mem=2047M" boot argument would help...

Ivan.
