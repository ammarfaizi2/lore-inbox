Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTIZDvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 23:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTIZDvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 23:51:44 -0400
Received: from havoc.gtf.org ([63.247.75.124]:51177 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261914AbTIZDvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 23:51:42 -0400
Date: Thu, 25 Sep 2003 23:49:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Len Brown <len.brown@intel.com>
Cc: marcelo@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030926034951.GA12338@gtf.org>
References: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk> <3F738288.5060304@pobox.com> <1064547463.2981.833.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064547463.2981.833.camel@dhcppc4>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:37:43PM -0400, Len Brown wrote:
> > How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?
> > 
> > If enabled and CONFIG_SMP is set, then we will attempt to discover HT 
> > via ACPI tables, regardless of CONFIG_ACPI value.
> 
> Yes, except I think we should keep the name CONFIG_ACPI_HT_ONLY since it
> says exactly what it does.
> 
> Hopefully I can make it looke clear in the menus --
> I think on the config menus for CONFIG_ACPI_HT_ONLY and CONFIG_ACPI
> should be mutually exclusive.

Now that I've thought of it (aren't I humble), I rather like CONFIG_HT.
It's simple and it's effects should be obvious to both developer and
user:

	CONFIG_HT, CONFIG_ACPI == ACPI
	!CONFIG_HT, CONFIG_ACPI == ACPI
	CONFIG_HT, !CONFIG_ACPI == HT-only ACPI
	!CONFIG_HT, !CONFIG_ACPI == no ACPI

Following the "autoconf model", what we really want to be testing with
CONFIG_xxx is _features_, where possible. "hyperthreading: yes/no" is
IMO more clear than "do I want ht-only ACPI or full ACPI", while at the
same time being more fine-grained and future-proof.


> > Or... (I know multiple people will shoot me for saying this) we could 
> > resurrect acpitable.[ch], and build that when CONFIG_ACPI is disabled.
> 
> The question about configs is independent of the acpitable.[ch] vs
> table.c implementation.  No, we should not return to maintaining two
> copies of the acpi table code.

Point; agreed.

	Jeff


