Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTETW4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTETWxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:53:46 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:31754 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id S261417AbTETWwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:52:33 -0400
Message-ID: <3ECAFB49.3020207@trancecode.co.uk>
Date: Wed, 21 May 2003 00:06:33 -0400
From: colin <colin@trancecode.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: repeatable freeze with ide-scsi and RH8.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a short post, so please feel free to stop reading now if you 
are not interested in my ide-scsi problem. :-)

I have tried to accumulate as much evidence as possible before mailing 
the list, and quite possibly Alan may already have an upcoming fix for 
my problem !

Machine is a compaq deskpro small form factor p2 350 running RedHat 
linux 8.0 fully updated.

hdd is a cdrw mounted with
kernel parameter hdd=ide-scsi

After viewing (with xine) an .avi on cd for ~50 minutes the kernel hung.
This happens repeatedly at around same place on the cd.

I think that the cd medium itself is fine because
1) it works on winblows
2) I copied the file to hdc and it playes fine
3) No hang if I use the cdrw as a cdrom drive by removing hdd=ide-scsi

After the hang-
caps lock and scroll lock keyboard lights flash on togethet about once a 
second
there is no response from cntr-alt-del
or alt-sysrq keys
machine is dead to ping

on one accasion I reacted quickly as soon as the cd stopped spinning and 
was able to immediately exit kde,
the console was filled with an endless loop of what i guess was a
stack dump (it scrolled past too fast to read)

   here is a relevent snip from /var/log/message

May 20 16:35:39 bob kernel: scsi : aborting command due to timeout : pid
387222, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     this is the only sign of the freeze up.

I experimented with several combinations of kernel and parameters
and one time managed to get a stack dump on freeze
(kernel on this occasion was RH 2.4.18-24.7.x)

-this typed in manually from frozen screen

[<>] ide_timer_expiry [kernel] ox175 (0xc31e9dd0)
[<>] ide_timer_expiry [kernel] 0x0 (0xc31e9de4)
[<>] timer_bh [kernel] 0x257 (0xc31e9df0)
[<>] do_timer [kernel] 0x45 (0xc31e9dfc)
[<>] bh_action [kernel] 0x1b (0xc31e9e18)
[<>] tasklet_hi_action [kernel] 0x44 (0xc31e9e1c)
[<>] do_softirq [kernel] 0x4b (0xc31e9e30)
[<>] do_IRQ [kernel] 0x4b (0xc31e9e48)
[<>] call_do_IRQ [kernel] 0x5 (0xc31e9e5c)
[<>] proc_base_lookup [kernel] 0x5f (0xc31e9e88)
[<>] real lookup [kernel] 0x4f (0xc31e9ebc)
[<>] link_path_walk [kernel] 0x654 (0xc31e9ed8)
[<>] destroy_inode [kernel] 0x3d (0xc31e9f14)
[<>] iput [kernel] 0x1c5 (0xc31e9f24)
[<>] path_lookup [kernel] 0x1b (0xc31e9f38)
[<>] filp_open [kernel] 0xbf (0xc31e9f48)
[<>] fput [kernel] 0xaf (0xc31e9f68)
[<>] sys_open [kernel] 0x34 (0xc31e9fa8)
[<>] system_call [kernel] 0x33 (0xc31e9fc0)

Code: 8b 56 18 89 70 04 8b 46 1c c7 46 10 00 00 00 00 8b 7e 0c 09
  <0>Kernel panic: Aiee, killing interrupt handler!
  In interrupt handler - not syncing

I have played the relevant part of the file repeatedly without using 
ide-scsi and it has never hung, although occasionally the read will 
fail, but xine can be restarted and then viewing continued without incident
on such an occsion the message.log entry was

May 20 20:54:27 bob kernel: hdd: irq timeout: status=0xd0 { Busy }
May 20 20:54:27 bob kernel: hdd: ATAPI reset complete

Full boot.log and message.log available if requested.
I hope that this information is of use to someone here on lkml

Colin Redfern

Software Developer
Trancecode ltd.

