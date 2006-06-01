Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWFAVmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWFAVmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWFAVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:42:54 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:1196 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750770AbWFAVmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:42:53 -0400
Date: Thu, 1 Jun 2006 17:39:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind
  transparent bridge
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Lane <miles.lane@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606011741_MC3-1-C158-4567@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060601095335.c778bc98.akpm@osdl.org>

On Thu, 1 Jun 2006 09:53:35 -0700, Andrew Morton wrote:

> On Thu, 1 Jun 2006 10:52:26 -0400
> "Miles Lane" <miles.lane@gmail.com> wrote:
> 
> > PCI: Transparent bridge - 0000:00:1e.0
> > PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
> > (try 'pci=assign-busses')
> > Please report the result to linux-kernel to fix this permanently
> 
> I guess you're supposed to try 'pci=assign-busses'.
> 
> Does the machine work OK without pci=assign-busses?
> 
> Does the machine work OK with pci=assign-busses?
> 
> Greg, what are we supposed to be doing here?  Grab the PCI IDs and add a
> quirk somewhere?

I get that message all the time and it's annoying because pci=assign-busses
does nothing but change the bus numbers.  No new devices or busses appear.
System is Compaq Presario v2000 notebook with ATI chipset and AMD Turion CPU.


Without pci=assign-busses:

dmesg:
PCI: Transparent bridge - 0000:00:14.4
PCI: Bus #06 (-#09) is hidden behind transparent bridge #05 (-#06) (try 'pci=assign-busses')

lspci -t:
-[0000:00]-+-00.0
           +-01.0-[0000:01]----05.0
           +-13.0
           +-13.1
           +-13.2
           +-14.0
           +-14.1
           +-14.3
           +-14.4-[0000:05-06]--+-00.0
           |                    +-02.0
           |                    +-09.0
           |                    +-09.2
           |                    +-09.3
           |                    \-09.4
           +-14.5
           +-14.6
           +-18.0
           +-18.1
           +-18.2
           \-18.3



With pci=assign-busses:

lspci -t:
-[0000:00]-+-00.0
           +-01.0-[0000:01]----05.0
           +-13.0
           +-13.1
           +-13.2
           +-14.0
           +-14.1
           +-14.3
           +-14.4-[0000:02-06]--+-00.0
           |                    +-02.0
           |                    +-09.0
           |                    +-09.2
           |                    +-09.3
           |                    \-09.4
           +-14.5
           +-14.6
           +-18.0
           +-18.1
           +-18.2
           \-18.3

-- 
Chuck
