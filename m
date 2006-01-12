Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWALWdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWALWdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWALWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:33:17 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24502 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030437AbWALWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:33:16 -0500
Date: Thu, 12 Jan 2006 16:33:06 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Don Fry <brazilnut@us.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Daniel Drake <dsd@gentoo.org>,
       Jon Mason <jdmason@us.ibm.com>, mulix@mulix.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pcnet32 devices with incorrect trident vendor ID
Message-ID: <20060112223306.GJ17539@us.ibm.com>
Mail-Followup-To: Don Fry <brazilnut@us.ibm.com>,
	Matthew Wilcox <matthew@wil.cx>, Daniel Drake <dsd@gentoo.org>,
	Jon Mason <jdmason@us.ibm.com>, mulix@mulix.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <20060112175051.GA17539@us.ibm.com> <43C6C0E6.7030705@gentoo.org> <20060112205714.GK19769@parisc-linux.org> <20060112210559.GL19769@parisc-linux.org> <20060112212205.GA28395@devserv.devel.redhat.com> <20060112212435.GB28395@devserv.devel.redhat.com> <20060112222320.GA19668@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112222320.GA19668@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:23:20PM -0800, Don Fry wrote:
> There are just a few differences between the 2.4 (1.30h) version of
> pcnet32.c and the 2.6 (1.30j) version, as I have tried to keep them
> as similar as possible.
> 
> The driver was changed in February 2004 to recognize the incorrect
> vendor ID so that the ppc workaround was no longer required, and so that
> the cards would work in non ppc systems.  From the driver perspective
> the ppc workaround could be deleted.
> 
> On my systems lspci shows all the devices with the correct name whether
> it is ppc or x86.

Funny, I get the following on my opteron system:

# lspci | grep Ethernet
0000:03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
0000:0e:01.0 Ethernet controller: Trident Microsystems 4DWave DX (rev 26)

> 
> PPC:
> donf@elm3b48:/usr/src> lspci | grep Ethernet
> 0000:01:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 54)
> 0000:21:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 0d)
> 0000:62:00.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 26)
> 0000:62:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 26)
> 0000:62:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 26)
> 0000:62:03.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 26)
> 0001:21:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 44)
> 0001:31:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 26)
> 0001:41:01.0 Ethernet controller: Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
> 0001:61:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c978 [HomePNA] (rev 51)
> donf@elm3b48:/usr/src>
> 
> x86:
> [donf@elm3b45 linux-2.6.14-git11]$ lspci | grep Ethernet
> 00:01.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 54)
> 00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
> 02:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 16)
> 02:06.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 36)
> 05:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
> 05:03.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 54)
> 05:04.0 Ethernet controller: Advanced Micro Devices [AMD] 79c978 [HomePNA] (rev 51)
> [donf@elm3b45 linux-2.6.14-git11]$ 
> 
> On Thu, Jan 12, 2006 at 04:24:35PM -0500, Bill Nottingham wrote:
> > Bill Nottingham (notting@redhat.com) said: 
> > > I remember looking at this a while back. I think the corrected information
> > > is only being propagated to the 'vendor' file, and the write_config_word
> > > isn't actually updating the 'config' entry in sysfs.
> > 
> > Ah, here's an example from the box I remember working on this on
> > (without the libpci change):
> > 
> > root@pseries 0000:00:0c.0]# pwd
> > /sys/bus/pci/devices/0000:00:0c.0
> > [root@pseries 0000:00:0c.0]# lspci | grep 0c.0
> > 00:0c.0 Ethernet controller: Trident Microsystems 4DWave DX (rev 26)
> > [root@pseries 0000:00:0c.0]# lspci -n | grep 0c.0
> > 00:0c.0 Class 0200: 1023:2000 (rev 26)
> > [root@pseries 0000:00:0c.0]# cat vendor
> > 0x1022
> > [root@pseries 0000:00:0c.0]# cat device
> > 0x2000
> > [root@pseries 0000:00:0c.0]# od -x config
> > 0000000 2310 0020 4701 8002 2600 0002 0048 0000
> > 0000020 01f0 ff00 0070 21c3 0000 0000 0000 0000
> > 0000040 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000060 0000 10c3 0000 0000 0000 0000 1101 06ff
> > 0000100 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000400
> > 
> > Note that the config space is different than the vendor file. This
> > was with 2.6.9-ish, I don't have the box around any more to confirm
> > with something more recent.
> > 
> > Bill
> -- 
> Don Fry
> brazilnut@us.ibm.com
> 
