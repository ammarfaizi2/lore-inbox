Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135271AbRDLTm7>; Thu, 12 Apr 2001 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135281AbRDLTmZ>; Thu, 12 Apr 2001 15:42:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28076 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135279AbRDLTkc>;
	Thu, 12 Apr 2001 15:40:32 -0400
Message-ID: <3AD604B0.2713F08B@mandrakesoft.com>
Date: Thu, 12 Apr 2001 15:40:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: modica@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal for a new PCI function call
In-Reply-To: <3AD601B4.7E0B14E4@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Modica wrote:
> 
> Hi All,
> 
> We found recently that the acenic driver for the 3com gigabit ethernet card does
> not enable 64 bit DMAs.  (this is done by setting the appropriate mask in
> pci_dev->dma_mask).
> 
> Jes suggested that the appropriate way to fix this would be to create a function
> like pci_enable_dma64 and then have the driver call that, rather than directly
> setting this value (a small handful of drivers do this now).
> 
> I think the function idea would let us do some sanity checking to make sure
> drivers weren't setting this to 64bit on non-64 bit busses and stuff.

pci_set_dma_mask.  Modify that to do the additional checks you need.

Nobody should be setting dma_mask directly anymore, it should be done
through this function.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
