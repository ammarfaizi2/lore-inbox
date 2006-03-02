Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752079AbWCBXPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbWCBXPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWCBXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:15:42 -0500
Received: from mxout2.netvision.net.il ([194.90.9.21]:40765 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S1752075AbWCBXP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:15:28 -0500
Date: Fri, 03 Mar 2006 01:15:39 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <20060302173846.GF498@andrew-vasquezs-powerbook-g4-15.local>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Stefan Kaltenbrunner <mm-mailinglist@madness.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <862131446.20060303011539@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
 <978150825.20060227210552@netvision.net.il>
 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
 <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il>
 <20060302173846.GF498@andrew-vasquezs-powerbook-g4-15.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!
Please see the log with debug-patch.
The module is loaded with option qlport_down_retry=1.
Adapter 4 is connected to switch, adapter 5 doesn't have cable attached.
After reconnecting the cable the disks don't reappear and rescan is stuck.
Before applying your patches ghost rport was staying, now it's OK.

Thanks,

Maxim.

# egrep -v 'Vendor|cron' /var/log/messages
Mar  3 01:05:17 multipath kernel: QLogic Fibre Channel HBA Driver
Mar  3 01:05:17 multipath kernel: GSI 24 sharing vector 0xE9 and IRQ 24
Mar  3 01:05:17 multipath kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 233
Mar  3 01:05:17 multipath kernel: qla2xxx 0000:03:01.0: Found an ISP2312, irq 233, iobase 0xffffc20000004000
Mar  3 01:05:17 multipath kernel: qla2xxx 0000:03:01.0: Configuring PCI space...
Mar  3 01:05:17 multipath kernel: qla2xxx 0000:03:01.0: Configure NVRAM parameters...
Mar  3 01:05:17 multipath kernel: qla2xxx 0000:03:01.0: Verifying loaded RISC code...
Mar  3 01:05:17 multipath kernel: scsi(4): **** Load RISC code ****
Mar  3 01:05:17 multipath kernel: scsi(4): Verifying Checksum of loaded RISC code.
Mar  3 01:05:17 multipath kernel: scsi(4): Checksum OK, start firmware.
Mar  3 01:05:17 multipath kernel: scsi(4): Issue init firmware.
Mar  3 01:05:17 multipath kernel: qla2xxx 0000:03:01.0: Waiting for LIP to complete...
Mar  3 01:05:19 multipath kernel: scsi(4): Asynchronous LIP RESET (f7f7).
Mar  3 01:05:19 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
Mar  3 01:05:19 multipath kernel: scsi(4): Asynchronous P2P MODE received.
Mar  3 01:05:20 multipath kernel: scsi(4): Asynchronous LOOP UP (2 Gbps).
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
Mar  3 01:05:20 multipath kernel: scsi(4): Asynchronous PORT UPDATE.
Mar  3 01:05:20 multipath kernel: scsi(4): Port database changed ffff 0006 0000.
Mar  3 01:05:20 multipath kernel: scsi(4): F/W Ready - OK
Mar  3 01:05:20 multipath kernel: scsi(4): fw_state=3 curr time=ffff3dac.
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:03:01.0: Topology - (F_Port), Host Loop address 0xffff
Mar  3 01:05:20 multipath kernel: scsi(4): Configure loop -- dpc flags =0x4080040
Mar  3 01:05:20 multipath kernel: scsi(4): RSCN queue entry[0] = [00/000000].
Mar  3 01:05:20 multipath kernel: scsi(4): device_resync: rscn overflow.
Mar  3 01:05:20 multipath kernel: scsi(4): RFT_ID exiting normally.
Mar  3 01:05:20 multipath kernel: scsi(4): RFF_ID exiting normally.
Mar  3 01:05:20 multipath kernel: scsi(4): RNN_ID exiting normally.
Mar  3 01:05:20 multipath kernel: scsi(4): RSNN_NN exiting normally.
Mar  3 01:05:20 multipath kernel: scsi(4): GID_PT entry - nn 200000e08b079a69 pn 210000e08b079a69 portid=010700.
Mar  3 01:05:20 multipath kernel: scsi(4): GID_PT entry - nn 2000001738279c00 pn 1000001738279c11 portid=010200.
Mar  3 01:05:20 multipath kernel: scsi(4): device wrap (010200)
Mar  3 01:05:20 multipath kernel: scsi(4): Trying Fabric Login w/loop id 0x0081 for port 010200.
Mar  3 01:05:20 multipath kernel: scsi(4): LOOP READY
Mar  3 01:05:20 multipath kernel: DEBUG: detect hba 4 at address = ffff81006f5f8548
Mar  3 01:05:20 multipath kernel: scsi4 : qla2xxx
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:03:01.0:
Mar  3 01:05:20 multipath kernel:  QLogic Fibre Channel HBA Driver: 8.01.04-k-debug
Mar  3 01:05:20 multipath kernel:   QLogic QLA2340 -
Mar  3 01:05:20 multipath kernel:   ISP2312: PCI-X (133 MHz) @ 0000:03:01.0 hdma-, host#=4, fw=3.03.18 IPX
Mar  3 01:05:20 multipath kernel: GSI 25 sharing vector 0x32 and IRQ 25
Mar  3 01:05:20 multipath kernel: ACPI: PCI Interrupt 0000:06:01.0[A] -> GSI 72 (level, low) -> IRQ 50
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:06:01.0: Found an ISP2312, irq 50, iobase 0xffffc20000006000
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:06:01.0: Configuring PCI space...
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:06:01.0: Configure NVRAM parameters...
Mar  3 01:05:20 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  3 01:05:20 multipath kernel: SCSI device sdb: 33554432 512-byte hdwr sectors (17180 MB)
Mar  3 01:05:20 multipath kernel: sdb: Write Protect is off
Mar  3 01:05:20 multipath kernel: SCSI device sdb: drive cache: write through
Mar  3 01:05:20 multipath kernel: SCSI device sdb: 33554432 512-byte hdwr sectors (17180 MB)
Mar  3 01:05:20 multipath kernel: sdb: Write Protect is off
Mar  3 01:05:20 multipath kernel: SCSI device sdb: drive cache: write through
Mar  3 01:05:20 multipath kernel:  sdb: unknown partition table
Mar  3 01:05:20 multipath kernel: sd 4:0:0:0: Attached scsi disk sdb
Mar  3 01:05:20 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  3 01:05:20 multipath kernel: SCSI device sdc: 67108864 512-byte hdwr sectors (34360 MB)
Mar  3 01:05:20 multipath kernel: sdc: Write Protect is off
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:06:01.0: Verifying loaded RISC code...
Mar  3 01:05:20 multipath kernel: scsi(5): **** Load RISC code ****
Mar  3 01:05:20 multipath kernel: SCSI device sdc: drive cache: write through
Mar  3 01:05:20 multipath kernel: SCSI device sdc: 67108864 512-byte hdwr sectors (34360 MB)
Mar  3 01:05:20 multipath kernel: sdc: Write Protect is off
Mar  3 01:05:20 multipath kernel: SCSI device sdc: drive cache: write through
Mar  3 01:05:20 multipath kernel:  sdc: unknown partition table
Mar  3 01:05:20 multipath kernel: sd 4:0:0:1: Attached scsi disk sdc
Mar  3 01:05:20 multipath scsi.agent[4295]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:0
Mar  3 01:05:20 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  3 01:05:20 multipath kernel: scsi(5): Verifying Checksum of loaded RISC code.
Mar  3 01:05:20 multipath kernel: sdd : very big device. try to use READ CAPACITY(16).
Mar  3 01:05:20 multipath kernel: SCSI device sdd: 9797894144 512-byte hdwr sectors (5016522 MB)
Mar  3 01:05:20 multipath kernel: sdd: Write Protect is off
Mar  3 01:05:20 multipath scsi.agent[4330]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:1
Mar  3 01:05:20 multipath kernel: SCSI device sdd: drive cache: write through
Mar  3 01:05:20 multipath scsi.agent[4342]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:2
Mar  3 01:05:20 multipath kernel: sdd : very big device. try to use READ CAPACITY(16).
Mar  3 01:05:20 multipath kernel: SCSI device sdd: 9797894144 512-byte hdwr sectors (5016522 MB)
Mar  3 01:05:20 multipath kernel: scsi(5): Checksum OK, start firmware.
Mar  3 01:05:20 multipath kernel: sdd: Write Protect is off
Mar  3 01:05:20 multipath kernel: SCSI device sdd: drive cache: write through
Mar  3 01:05:20 multipath kernel:  sdd: unknown partition table
Mar  3 01:05:20 multipath kernel: sd 4:0:0:2: Attached scsi disk sdd
Mar  3 01:05:20 multipath kernel: scsi(5): Issue init firmware.
Mar  3 01:05:20 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0006/7ee5.
Mar  3 01:05:20 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0007/7ee5.
Mar  3 01:05:20 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0004/7ee5.
Mar  3 01:05:20 multipath kernel: qla2xxx 0000:06:01.0: Waiting for LIP to complete...
Mar  3 01:05:21 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0081/0006/7ee5.
Mar  3 01:05:41 multipath kernel: qla2xxx 0000:06:01.0: Cable is unplugged...
Mar  3 01:05:41 multipath kernel: scsi(5): fw_state=4 curr time=ffff522d.
Mar  3 01:05:41 multipath kernel: scsi(5): Firmware ready **** FAILED ****.
Mar  3 01:05:41 multipath kernel: DEBUG: detect hba 5 at address = ffff81006e8f0548
Mar  3 01:05:41 multipath kernel: scsi5 : qla2xxx
Mar  3 01:05:41 multipath kernel: qla2xxx 0000:06:01.0:
Mar  3 01:05:41 multipath kernel:  QLogic Fibre Channel HBA Driver: 8.01.04-k-debug
Mar  3 01:05:41 multipath kernel:   QLogic QLA2340 -
Mar  3 01:05:41 multipath kernel:   ISP2312: PCI-X (133 MHz) @ 0000:06:01.0 hdma-, host#=5, fw=3.03.18 IPX
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:46 multipath kernel: qla2x00_mailbox_command(5): **** FAILED. mbx0=4005, mbx1=0, mbx2=6e92, cmd=6b ****
Mar  3 01:05:46 multipath kernel: qla2x00_get_link_status(5): failed=102.
Mar  3 01:05:46 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  3 01:05:50 multipath kernel: scsi(5): Loop Down - aborting the queues before time expire
-------------------------------
Disconnecting the cable
Mar  3 01:06:34 multipath kernel: scsi(4): Asynchronous LOOP DOWN (2).
Mar  3 01:06:34 multipath kernel: qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
Mar  3 01:06:34 multipath kernel: scsi(4): fcport-0 - port retry count: 0 remaining
Mar  3 01:06:40 multipath kernel:  rport-4:0-0: blocked FC remote port time out: removing target and saving binding
Mar  3 01:06:42 multipath kernel: scsi(4): Loop Down - aborting the queues before time expire
Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous LIP RESET (f7f7).
Mar  3 01:07:22 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
Mar  3 01:07:22 multipath kernel: scsi(4): qla2x00_reset_marker()
Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous P2P MODE received.
Mar  3 01:07:22 multipath kernel: scsi(4): qla2x00_reset_marker()
Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous LOOP UP (2 Gbps).
Mar  3 01:07:22 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous PORT UPDATE.
Mar  3 01:07:22 multipath kernel: scsi(4): Port database changed ffff 0006 7ee5.
Mar  3 01:07:22 multipath kernel: scsi(4): qla2x00_loop_resync()
Mar  3 01:07:22 multipath kernel: scsi(4): F/W Ready - OK
Mar  3 01:07:22 multipath kernel: scsi(4): fw_state=3 curr time=ffffb533.
Mar  3 01:07:22 multipath kernel: scsi(4): Configure loop -- dpc flags =0x4090060
Mar  3 01:07:22 multipath kernel: scsi(4): RSCN queue entry[0] = [00/000000].
Mar  3 01:07:22 multipath kernel: scsi(4): device_resync: rscn overflow.
Mar  3 01:07:22 multipath kernel: scsi(4): RFT_ID exiting normally.
Mar  3 01:07:22 multipath kernel: scsi(4): RFF_ID exiting normally.
Mar  3 01:07:22 multipath kernel: scsi(4): RNN_ID exiting normally.
Mar  3 01:07:22 multipath kernel: scsi(4): RSNN_NN exiting normally.
Mar  3 01:07:22 multipath kernel: scsi(4): GID_PT entry - nn 200000e08b079a69 pn 210000e08b079a69 portid=010700.
Mar  3 01:07:22 multipath kernel: scsi(4): GID_PT entry - nn 2000001738279c00 pn 1000001738279c11 portid=010200.
Mar  3 01:07:22 multipath kernel: scsi(4): device wrap (010200)
Mar  3 01:07:22 multipath kernel: scsi(4): Trying Fabric Login w/loop id 0x0081 for port 010200.
Mar  3 01:07:22 multipath kernel: scsi(4): LOOP READY
Mar  3 01:07:22 multipath kernel: scsi(4): qla2x00_loop_resync - end
Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0081/0007/7ee5.
Mar  3 01:07:22 multipath kernel: scsi(4:0:0): status_entry: Port Down pid=43, compl status=0x29, port state=0x4
Mar  3 01:07:22 multipath kernel: scsi(4): Port login retry: 1000001738279c11, id = 0x0081 retry cnt=8
Mar  3 01:07:23 multipath kernel: scsi(4): fcport-0 - port retry count: 0 remaining
Mar  3 01:07:23 multipath kernel: scsi(4): qla2x00_port_login()
Mar  3 01:07:23 multipath kernel: scsi(4): Trying Fabric Login w/loop id 0x0081 for port 010200.
Mar  3 01:07:23 multipath kernel: scsi(4): port login OK: logged in ID 0x81
Mar  3 01:07:23 multipath kernel: scsi(4): qla2x00_port_login - end
Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0006/0001.
Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0007/0001.
Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0004/0001.
Mar  3 01:07:24 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0081/0006/0001.
Mar  3 01:09:56 multipath kernel: scsi(5): Loop down exceed 4 mins - restarting queues.


