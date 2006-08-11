Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWHKLIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWHKLIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 07:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWHKLIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 07:08:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33305 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932100AbWHKLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 07:08:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EpAydcoF02G3AHwtP8Bn3Yl6SzHT1G7a7ts6s9OFC2Uryv+o5gANDRD2Mffg73/n9C5NVJyjp6XWl+3br87nz7CaA3jsA6XX/Hz6JhsNfN+iGm0eNzrlqOqUWCzRubHnWUasdbVsiNPcUnF9v7JgNIy7nko0/2VW0/nPuI+jECQ=
Message-ID: <f96157c40608110408u65a4cedege5477c60100d2a3f@mail.gmail.com>
Date: Fri, 11 Aug 2006 11:08:32 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Simen Thoresen" <simentt@dolphinics.no>
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Cc: "Joel Jaeggli" <joelja@uoregon.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <44DBA06E.40104@dolphinics.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808101504.GJ2152@stingr.net>
	 <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
	 <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>
	 <20060809074815.bec7f32c.joelja@uoregon.edu>
	 <f96157c40608090754m1f10e0f2h5fbf3b256d2e55e1@mail.gmail.com>
	 <44DBA06E.40104@dolphinics.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Simen Thoresen <simentt@dolphinics.no> wrote:
> gmu 2k6 wrote:
> ...
> > so what does it mean that one of Xeons here shows me the full 4GiB as
> > total physical memory via `free`?
> >
> > btw, the box I'm getting will have the 975X chip and include 4GiB RAM
> > and if I understood the problem correctly even with 3GiB there will be
> > some memory lost to mapping-issues besides the HI/LO mem
> > kernel-reserving issue.
> > this is what I get on ia32 P4 with 3GiB
> >             total       used       free     shared    buffers     cached
> > Mem:       3116108    2608196     507912          0     246652    2039708
> > and this is what I get on ia32 Xeon with 4GiB
> >             total       used       free     shared    buffers     cached
> > Mem:       4087660     268828    3818832          0      57168     103568
>
> Hi Gmu,
>
> This is a bit divergent from the discussion, but will hopefully provide some
> background.
>
> The hardware my employer manufactures asks the BIOS to reserve several
> largeish ranges (16M and 16M to 512M), and it's been used in various HPC
> projects where machines typically have a lot of memory installed.
>
>  From my experience, most pre 750x-P4-Xeon chipsets did not support any kind
> of memory remapping, so often the top 0.5-1.5G of ram would be 'lost'. Great
> fun.
> Since then, this functionality has started appearing, more or less randomly.
> I believe it should be present on all later 75xx chipsets (probably the Core
> 2 Xeon chipsets as well), but implementation depends on the BIOS (ie the
> motherboard vendors), and their grasp of what people do with their boards is
> often quite limited.
>
> On the P4 boards (and again the Core 2 boards as well), this is probably
> even less ordered as they are 'desktop' boards rather than the more costly
> 'server' boards.
>
> I'm pretty sure the Athlon64 and Opteron CPUs should support this, but they
> too depend on BIOS functionality to rearrange the memory tables.
>
> Just out of interest - what chipset does your Xeon system use?

lspci of the P4 32bit desktop with 3GiB
00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller
Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP
Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02)

lspci of the Xeon 32bit HP Proliant Server with 4GiB:
00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A (rev 0c)
00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02)

lspci of the new box with 975X and Core 2 Duo not available yet for
obvious reasons (I don't have the the box yet).
