Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRKAItm>; Thu, 1 Nov 2001 03:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278589AbRKAItb>; Thu, 1 Nov 2001 03:49:31 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:40375 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278587AbRKAItX>; Thu, 1 Nov 2001 03:49:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hasch@t-online.de (Juergen Hasch)
To: linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?q?Lang=E5s?= <tlan@stud.ntnu.no>
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Thu, 1 Nov 2001 09:48:56 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com> <20011101090348.E2102@stud.ntnu.no>
In-Reply-To: <20011101090348.E2102@stud.ntnu.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15zDX1-1svMLQC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's the full /proc/net/PRO_LAN_Adapters/eth0.info output (after NFS
> timeouts):
>
> gekko:~# cat /proc/net/PRO_LAN_Adapters/eth0.info
> Description               Intel(R) 8255x-based Ethernet Adapter
> Driver_Name               e100
> Driver_Version            1.6.22
> PCI_Vendor                0x8086
> PCI_Device_ID             0x1229
> PCI_Subsystem_Vendor      0x1028
> PCI_Subsystem_ID          0x009b
> PCI_Revision_ID           0x0008
> PCI_Bus                   2
> PCI_Slot                  4
> IRQ                       16
> System_Device_Name        eth0
> Current_HWaddr            00:B0:D0:F0:8B:65
> Permanent_HWaddr          00:B0:D0:F0:8B:65
> Part_Number               07195d-000
>
> Link                      up
> Speed                     100
> Duplex                    full
> State                     up
>
> Rx_Packets                27747043
> Tx_Packets                25999146
> Rx_Bytes                  1730389022
> Tx_Bytes                  21884644
> Rx_Errors                 0
> Tx_Errors                 0
> Rx_Dropped                0
> Tx_Dropped                0
> Multicast                 0
> Collisions                0
> Rx_Length_Errors          0
> Rx_Over_Errors            0
> Rx_CRC_Errors             0
> Rx_Frame_Errors           0
> Rx_FIFO_Errors            0
> Rx_Missed_Errors          0
> Tx_Aborted_Errors         0
> Tx_Carrier_Errors         0
> Tx_FIFO_Errors            0
> Tx_Heartbeat_Errors       0
> Tx_Window_Errors          0
>
> Rx_TCP_Checksum_Good      0
> Rx_TCP_Checksum_Bad       0
> Tx_TCP_Checksum_Good      0
> Tx_TCP_Checksum_Bad       0
>
> Tx_Abort_Late_Coll        0
> Tx_Deferred_Ok            0
> Tx_Single_Coll_Ok         0
> Tx_Multi_Coll_Ok          0
> Rx_Long_Length_Errors     0
> Rx_Align_Errors           0
>
> Tx_Flow_Control_Pause     0
> Rx_Flow_Control_Pause     0
> Rx_Flow_Control_Unsup     0
>
> Tx_TCO_Packets            0
> Rx_TCO_Packets            1
> scbp = 0xf89da000        bddp = 0xf77568c0

Well this doesn't look exactly the same as on the system I had problems with.
But your Rx_TCO_Packets counter is  1, so this may be related
(I also got Rx overrun errors). It may be that your BMC receives the packet
and simply chooses to ignore it because it is no valid server management 
packet.

Could you make another test and take a look at the eth0.info ?
I could reproduce the problem when copying a large file over NFS, but not 
when transferring it via ftp. Try this a few times.
If you can reproduce you network card being stuck only when using NFS and 
having Rx_TCO_Packets > 0 after it is stuck, this is it.
Then you either need tu upgrade your BMC firmware or add another network card,
which doesn't eat NFS packets.

...Juergen

