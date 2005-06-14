Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFNVva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFNVva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFNVv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:51:28 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:30073 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261364AbVFNVvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucCgmg4IrL2yfI0rBeX8uTaXT6kYlmCYqkwgLv9U3qSYw/ZgN6/aaqeuW8+NU6DoQd6/G/tfnYTl8SkFP8SWtqRiayaxHsem+EPQXNT/XiNMRXQwRk468FLQxEilUR/0oUc8quZWNf3xeOlku6PrbXv7D1snZriBfCS2ouY6oEU=
Message-ID: <9e4733910506141451f2f28cf@mail.gmail.com>
Date: Tue, 14 Jun 2005 17:51:12 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Bob Picco <bob.picco@hp.com>
Subject: Re: Fwd: hpet patches
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614183812.GA5920@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004F77C29@scsmsx403.amr.corp.intel.com>
	 <9e473391050614092661d665ee@mail.gmail.com>
	 <20050614164605.GQ3728@localhost.localdomain>
	 <9e4733910506141050a7c7728@mail.gmail.com>
	 <20050614183812.GA5920@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Bob Picco <bob.picco@hp.com> wrote:
> Jon Smirl wrote:        [Tue Jun 14 2005, 01:50:49PM EDT]
> > Problem like this are usually fixed with quirks:
> >
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801EB_0,  quirk_intel_ich5_hpet);
> >
> > quirk_intel_ich5_hpet()
> > {
> >     if (!hpet_address)
> >           hpet_address = 0xfed00000ULL;
> > }
> >
> > 0xfed00000ULL is right for ICH5, do you want to start adding these as
> > part of HPET support? My hpet works fine once the address is set. For
> > complete coverage you need a list of these for all of the AMD/Intel
> > chipsets with hpet support. The list isn't very big.
> >
> Well my ignorance is going to show here.  The platform initialization code
> has already run and PCI probing happens later.  How do you reconcile Venki's
> concern for an HPET armed for legacy support when platform
> is already using PIT?  Also the hpet driver isn't a PCI driver but
> ACPI driver.  It's working for you so I'm obviously missing a detail.

You don't actually use the PCI_FIXUP macros. You make a new one called
ACPI_FIXUP and run them right after ACPI is read and before you do
anything else. I was just illustrating how the quirk fixup system
worked.

To make it work on my system I just added an assignment statement for
the fix right after the ACPI code looked for the HPET entry. But
that's not a general solution, building the ACPI_FIXUP macros is one.

-- 
Jon Smirl
jonsmirl@gmail.com
