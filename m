Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTGYDI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271891AbTGYDI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:08:57 -0400
Received: from CPE000625926cd6-CM014480115318.cpe.net.cable.rogers.com ([24.157.137.42]:10895
	"EHLO daedalus.samhome.net") by vger.kernel.org with ESMTP
	id S271890AbTGYDIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:08:52 -0400
Subject: Re: Firewire
From: Sam Bromley <sbromley@cogeco.ca>
Reply-To: sbromley@cogeco.ca
To: Ben Collins <bcollins@debian.org>
Cc: Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030725012908.GT1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com>
	 <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org>
	 <20030724230928.GB23196@ruvolo.net>
	 <1059095616.1897.34.camel@torrey.et.myrio.com>
	 <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1059103424.24427.108.camel@daedalus.samhome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 23:23:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 21:29, Ben Collins wrote:
> On Thu, Jul 24, 2003 at 06:27:24PM -0700, Chris Ruvolo wrote:
> > On Thu, Jul 24, 2003 at 06:13:37PM -0700, Torrey Hoffman wrote:
> > > Sometimes the driver seems to go into an loop of "unsolicted packet
> > > received" messages and attempted resets.  Here's what the log looks like
> > > when that happens:  (this was on 2.5.75)
> > [..]
> > > (this sequence repeats until I turn off or unplug the drive.)
> > 
> > This sounds like what happens to me when I turn on my DV cam.  CPU usage
> > goes up to 40% kernel and loops like that until the device goes off.
> > 
> > What hardware do you have?  lspci?
> > 
> > Marcello's latest 2.4.22-pre8 updates to rev 1010 of the 1394 modules, so
> > I'm curious if I can reproduce this in 2.4 now.
> 
> Could both you guys try this workaround? Should prove or disprove my
> theory.
> 
> Index: linux-2.6/drivers/ieee1394/ohci1394.c
> ===================================================================
> --- linux-2.6/drivers/ieee1394/ohci1394.c	(revision 1013)
> +++ linux-2.6/drivers/ieee1394/ohci1394.c	(working copy)
> @@ -2366,7 +2366,7 @@
>  			ohci1394_stop_context(ohci, d->ctrlClear,
>  					      "respTxComplete");
>  		else
> -			tasklet_schedule(&d->task);
> +			dma_trm_tasklet ((unsigned long)d);
>  		event &= ~OHCI1394_respTxComplete;
>  	}
>  	if (event & OHCI1394_RQPkt) {

For what it's worth, I'm experiencing this as well.
In the hopes of helping, I provide the dmesg
output results after applying the above patch to Rev 1013.
(Running 2.6.0-test1-ac1).

(Goes crazy after plugging in camera.)

<snip>

et received - np
ieee1394: contents: ffc11960 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc11d60 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc12160 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 49

ieee1394: Checking tlabel 50

ieee1394: Checking tlabel 51

ieee1394: Checking tlabel 52

ieee1394: Checking tlabel 53

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc12560 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc12960 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc12d60 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 54

ieee1394: Checking tlabel 55

ieee1394: Checking tlabel 56

ieee1394: Checking tlabel 57

ieee1394: Checking tlabel 58

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc13160 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc13560 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc13960 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 59

ieee1394: Checking tlabel 60

ieee1394: Checking tlabel 61

ieee1394: Checking tlabel 62

ieee1394: Checking tlabel 63

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc13d60 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc14160 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc14560 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 0

ieee1394: Checking tlabel 1

ieee1394: Checking tlabel 2

ieee1394: Checking tlabel 3

ieee1394: Checking tlabel 4

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc14960 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc14d60 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc15160 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 5

ieee1394: Checking tlabel 6

ieee1394: Checking tlabel 7

ieee1394: Checking tlabel 8

ieee1394: Checking tlabel 9

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc15560 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc15960 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc15d60 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 10

ieee1394: Checking tlabel 11

ieee1394: Checking tlabel 12

ieee1394: Checking tlabel 13

ieee1394: Checking tlabel 14

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc16160 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc16560 ffc10000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc16960 ffc10000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Checking tlabel 15

ieee1394: Checking tlabel 16

ieee1394: Checking tlabel 17

<snip>

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc06960 ffc00000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc06d60 ffc00000 00000000 2e5e0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc07160 ffc00000 00000000 2e5e0404
ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[0001687300012646]
video1394: Removed video1394 module
bad: scheduling while atomic!
Call Trace:
 [<c011a0d0>] schedule+0x3a0/0x3b0
 [<c01189b1>] do_page_fault+0x251/0x451
 [<c011a418>] wait_for_completion+0x78/0xd0
 [<c011a130>] default_wake_function+0x0/0x30
 [<c011a130>] default_wake_function+0x0/0x30
 [<c0126f22>] kill_proc_info+0x42/0x70
 [<e4ed0245>] nodemgr_remove_host+0x55/0xa0 [ieee1394]
 [<e4ecbc6b>] highlevel_remove_host+0x6b/0x80 [ieee1394]
 [<e4eb3a21>] ohci1394_pci_remove+0x41/0x230 [ohci1394]
 [<c01ecfeb>] pci_device_remove+0x3b/0x40
 [<c0233092>] device_release_driver+0x62/0x70
 [<c02330c0>] driver_detach+0x20/0x30
 [<c023331d>] bus_remove_driver+0x3d/0x80
 [<c0233743>] driver_unregister+0x13/0x28
 [<c01ed2b6>] pci_unregister_driver+0x16/0x30
 [<e4eb3edf>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c01317b3>] sys_delete_module+0x133/0x150
 [<c0144874>] sys_munmap+0x44/0x70
 [<c0109087>] syscall_call+0x7/0xb

If I can provide better information, let me know.

Sam Bromley.

