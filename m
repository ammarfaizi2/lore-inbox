Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTDPQfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTDPQd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:33:57 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:15488 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S264447AbTDPQdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:33:37 -0400
Date: Wed, 16 Apr 2003 18:45:28 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030416184528.19c20372.philippe.gramoulle@mmania.com>
In-Reply-To: <20030416004933.GI16706@phunnypharm.org>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416004933.GI16706@phunnypharm.org>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 15 Apr 2003 20:49:33 -0400
Ben Collins <bcollins@debian.org> wrote:

  | > The 1394 warnings are known about and I think Ben is working on it.
  | 
  | Yeah, they are fixed in the linux1394 tree. I'm getting ready to push
  | them to Linus.

You mean the tree available with :

svn checkout svn://svn.linux1394.org/ieee1394/trunk/ ieee1394 ?

Because i tried with checkouted revision 867 few minutes ago and i still have the "bad: scheduling
while atomic!" message when i rmmod the modules ( modules init tools were upgraded to 0.9.11a)

DV camcorder still doesn't seem to work ( with dvgrab for example )

# dmesg
oot is not IRM capable, resetting...
ieee1394: Remote root is not IRM capable, resetting...
ieee1394: Remote root is not IRM capable, resetting...
ieee1394: Remote root is not IRM capable, resetting...
[message repeated 178 times and as long as the DV Camcorder in turned on]
ieee1394: Remote root is not IRM capable, resetting...
ieee1394: Remote root is not IRM capable, resetting...

Starting to rmmod the 1394 modules:

dv1394: shutdown...
dv1394: stop_dma: already stopped.
dv1394: shutdown complete
dv1394: shutdown...
dv1394: stop_dma: already stopped.
dv1394: shutdown complete
dv1394: shutdown...
dv1394: stop_dma: already stopped.
dv1394: shutdown complete
dv1394: shutdown...
dv1394: stop_dma: already stopped.
dv1394: shutdown complete
bad: scheduling while atomic!
Call Trace:
 [<c011cccb>] schedule+0x53b/0x540
 [<c011d06d>] wait_for_completion+0x9d/0xf0
 [<c011cd20>] default_wake_function+0x0/0x20
 [<c011cd20>] default_wake_function+0x0/0x20
 [<c012ba9f>] kill_proc_info+0x4f/0x80
 [<e0b84f4b>] nodemgr_remove_host+0x8b/0x100 [ieee1394]
 [<e0b80916>] highlevel_remove_host+0x66/0x70 [ieee1394]
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0b80269>] hpsb_remove_host+0x29/0x80 [ieee1394]
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0b4b84e>] ohci1394_pci_remove+0x3e/0x160 [ohci1394]
 [<c023c846>] pci_device_remove+0x36/0x40
 [<c0266866>] device_release_driver+0x66/0x70
 [<e0b4e6dc>] ohci1394_pci_driver+0x7c/0xa0 [ohci1394]
 [<e0b4e6dc>] ohci1394_pci_driver+0x7c/0xa0 [ohci1394]
 [<c026689b>] driver_detach+0x2b/0x40
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<c0266b2c>] bus_remove_driver+0x3c/0x80
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<c0266f74>] driver_unregister+0x14/0x2a
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0b4e700>] +0x0/0x100 [ohci1394]
 [<e0b4bcf2>] +0x12/0x20 [ohci1394]
 [<e0b4e688>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<c0136f94>] sys_delete_module+0x1a4/0x1e0
 [<e0b4e700>] +0x0/0x100 [ohci1394]
 [<c014a134>] sys_munmap+0x44/0x70
 [<c010b49f>] syscall_call+0x7/0xb


Thanks,

Philippe
