Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFNXgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFNXgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVFNXgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:36:46 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:2624 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261420AbVFNXgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:36:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OZAiBMrshWZJa2yIN3KiVlUMqnBQskLNowHYilJF/TWeTORBQM7Ug/40DFSdSyTeCwO+lPdqDc98JHRlylabHDVeZnzeC8Zc7SgBaaoKWTn0fKps4ch17/gFR9UvEQEbiY/aA0+7zPxMeeEq9uS1hwLSuDeiC7AIIEO154iNogI=
Message-ID: <9e47339105061416365f4cd1eb@mail.gmail.com>
Date: Tue, 14 Jun 2005 19:36:42 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Fwd: hpet patches
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004F7837A@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004F7837A@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> HPET device itself can be there. But, it can appear in different
> addresses. Most commonly used address is 0xfed00000. But, it can be
> different as well.

Does Intel build different versions of something like an 82801EB with
the HPET at different addresses and still have the same part number?
For a specific part number/PCI ID isn't HPET always in the same place?
If the HPET is going to be in a different place I would expected the
chip would have a different PCI ID.

I would think that the ACPI fixup table would look something like:
ACPI_FIXUP(INTEL, ICH4, hpet_ich4_fixup)
ACPI_FIXUP(INTEL, ICH4M, hpet_ich4m_fixup)
ACPI_FIXUP(INTEL, ICH5, hpet_ich5_fixup)
ACPI_FIXUP(INTEL, ICH6, hpet_ich6_fixup)

hpet_ich4_fixup()
{
     hpet_address = 0xfed00000; or whatever
}
hpet_ich4m_fixup()
{
     hpet_address = 0xfed00000; or whatever
}
hpet_ich5_fixup()
{
     hpet_address = 0xfed00000; or whatever
}
hpet_ich6_fixup()
{
     hpet_address = 0xfed00000; or whatever
}

or something like:
ACPI_FIXUP(INTEL, ICH4, hpet_ich4_fixup)
ACPI_FIXUP(INTEL, ICH4M, hpet_ich4m_fixup)
ACPI_FIXUP(INTEL, ICH5, hpet_standard_fixup)
ACPI_FIXUP(INTEL, ICH6, hpet_standard_fixup)
ACPI_FIXUP(INTEL, ICH6M, hpet_standard_fixup)
with one line for each chip (less than 10?) that Intel has released
containing an HPET.

hpet_standard_fixup()
{
     hpet_address = 0xfed00000;
}
hpet_ich4_fixup()
{
     hpet_address = special case;
}
hpet_ich4m_fixup()
{
     hpet_address = special case;
}

-- 
Jon Smirl
jonsmirl@gmail.com
