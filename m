Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUISVnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUISVnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUISVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:43:50 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63924 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264261AbUISVnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:43:49 -0400
Date: Sun, 19 Sep 2004 23:39:52 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040919213952.GA32570@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com> <414DF773.7060402@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414DF773.7060402@myrealbox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> :
[...]
> FWIW, it looks like init_board is setting PCIDAC in tp->cp_cmd but that 
> isn't updated to the card until after the rx ring is filled in 
> r8169_open.  This seems suspicious, since DMA memory is being allocated 
> possibly in >32-bit addresses but the card hasn't been told to support 
> that.  Fixing this doesn't seem to help, though...

rtl8169_hw_start() writes the CPlusCmd register before the ring descriptor
adresses are set. Can you elaborate why it would not be enough ?

Btw the r8169 driver in 2.6.9-rcX does not advertise NETIF_F_HIGHDMA: where
would a >32 bit address come from ?

> Turning off high DMA fixes it.  Maybe it just needs to be disabled until 
> someone figures out what's going on.

I am cooking a patch for it (+ check for PCI error).

As a side note, the r8169 chipset does not like DAC to be enabled on a
32bit system. I got the usual PCI error reported while trying it.

--
Ueimor
