Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161303AbWALVYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWALVYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWALVYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:24:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161284AbWALVYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:24:46 -0500
Date: Thu, 12 Jan 2006 16:24:35 -0500
From: Bill Nottingham <notting@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Daniel Drake <dsd@gentoo.org>, Jon Mason <jdmason@us.ibm.com>,
       mulix@mulix.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pcnet32 devices with incorrect trident vendor ID
Message-ID: <20060112212435.GB28395@devserv.devel.redhat.com>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Daniel Drake <dsd@gentoo.org>, Jon Mason <jdmason@us.ibm.com>,
	mulix@mulix.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <20060112175051.GA17539@us.ibm.com> <43C6C0E6.7030705@gentoo.org> <20060112205714.GK19769@parisc-linux.org> <20060112210559.GL19769@parisc-linux.org> <20060112212205.GA28395@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112212205.GA28395@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham (notting@redhat.com) said: 
> I remember looking at this a while back. I think the corrected information
> is only being propagated to the 'vendor' file, and the write_config_word
> isn't actually updating the 'config' entry in sysfs.

Ah, here's an example from the box I remember working on this on
(without the libpci change):

root@pseries 0000:00:0c.0]# pwd
/sys/bus/pci/devices/0000:00:0c.0
[root@pseries 0000:00:0c.0]# lspci | grep 0c.0
00:0c.0 Ethernet controller: Trident Microsystems 4DWave DX (rev 26)
[root@pseries 0000:00:0c.0]# lspci -n | grep 0c.0
00:0c.0 Class 0200: 1023:2000 (rev 26)
[root@pseries 0000:00:0c.0]# cat vendor
0x1022
[root@pseries 0000:00:0c.0]# cat device
0x2000
[root@pseries 0000:00:0c.0]# od -x config
0000000 2310 0020 4701 8002 2600 0002 0048 0000
0000020 01f0 ff00 0070 21c3 0000 0000 0000 0000
0000040 0000 0000 0000 0000 0000 0000 0000 0000
0000060 0000 10c3 0000 0000 0000 0000 1101 06ff
0000100 0000 0000 0000 0000 0000 0000 0000 0000
*
0000400

Note that the config space is different than the vendor file. This
was with 2.6.9-ish, I don't have the box around any more to confirm
with something more recent.

Bill
