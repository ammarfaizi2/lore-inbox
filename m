Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSGZDW4>; Thu, 25 Jul 2002 23:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGZDW4>; Thu, 25 Jul 2002 23:22:56 -0400
Received: from web20705.mail.yahoo.com ([216.136.226.178]:57614 "HELO
	web20705.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316739AbSGZDWz>; Thu, 25 Jul 2002 23:22:55 -0400
Message-ID: <20020726031413.83575.qmail@web20705.mail.yahoo.com>
Date: Thu, 25 Jul 2002 20:14:13 -0700 (PDT)
From: abhishek Sinha <aby_sinha@yahoo.com>
Subject: Intel Plumas Chipset and 100Mhz PCI cards
To: linux-kernel@vger.kernel.org
Cc: aby_sinha@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List member

I am using Intel ClearWater SE7500CW2 motherboard
which uses Pentium 4 based Xeon processors.Also the
motherboard has 2 PCI/PCI-X 64 bit 100Mhz slots.I am
trying to use Intel PCI-X Gigabit Card on the
machine.It works fine but when i check the /proc
entry, here is what i find.

/proc/net/PRO_LAN_Adapters/eth2 

escription                      Intel(R) PRO/1000
Network Connection
Part_Number                      a50484-006
Driver_Name                      e1000
Driver_Version                   4.3.2
PCI_Vendor                       0x8086
PCI_Device_ID                    0x1009
PCI_Subsystem_Vendor             0x8086
PCI_Subsystem_ID                 0x1109
PCI_Revision_ID                  0x02
PCI_Bus                          2
PCI_Slot                         1
PCI_Bus_Type                     PCI
PCI_Bus_Speed                    66MHz
PCI_Bus_Width                    64-bit
IRQ                              24
System_Device_Name               eth2
Current_HWaddr                   00:02:B3:9E:5A:1A
Permanent_HWaddr                 00:02:B3:9E:5A:1A

Link                             up
Speed                            1000
Duplex                           Full
State                            up

Rx_Packets                       0
Tx_Packets                       0
Rx_Bytes                         0
Tx_Bytes                         0
Rx_Errors                        0
Tx_Errors                        0
Rx_Dropped                       0
Tx_Dropped                       0
Multicast                        0
Collisions                       0
Rx_Length_Errors                 0
Rx_Over_Errors                   0
Rx_CRC_Errors                    0
Rx_Frame_Errors                  0
Rx_FIFO_Errors                   0
Rx_Missed_Errors                 0
Tx_Aborted_Errors                0
Tx_Carrier_Errors                0
Tx_FIFO_Errors                   0
Tx_Heartbeat_Errors              0
Tx_Window_Errors                 0
Tx_Abort_Late_Coll               0
Tx_Deferred_Ok                   0
Tx_Single_Coll_Ok                0
Tx_Multi_Coll_Ok                 0
Rx_Long_Length_Errors            0
Rx_Short_Length_Errors           0
Rx_Align_Errors                  0
Rx_Flow_Control_XON              0
Rx_Flow_Control_XOFF             0
Tx_Flow_Control_XON              0
Tx_Flow_Control_XOFF             0
Rx_CSum_Offload_Good             0
Rx_CSum_Offload_Errors           0

PHY_Media_Type                   Fiber


The card shows up as 66 Mhz slot even if the PCI slot
is offering 100Mhz speed.Then i checked with the
latest version of the intel e1000 driver.

In one of the files e1000_proc.c this is what i found.

static char *
 e1000_proc_bus_speed(void *data, size_t len, char
*buf)
 {
  e1000_bus_speed bus_speed = *(e1000_bus_speed
*)data;
         sprintf(buf,
                 bus_speed == e1000_bus_speed_33  ?
33MHz"  :
                 bus_speed == e1000_bus_speed_66  ?
"66MHz"  :
                 bus_speed == e1000_bus_speed_100 ?
"100MHz" :
                 bus_speed == e1000_bus_speed_133 ?
"133MHz" :
                 "UNKNOWN");
         return buf;
 }

So i guess this means that the driver does recognise
the bus speed of 100Mhz. I also went and looked into 
the data sheet of the PCI hub on the motherboard which
 is in the link below:

ftp://download.intel.com/design/chipsets/e7500/datashts/29073201.pdf

In page 50, a CNF register is defined which seems to
support configuration ar 100 Mhz or 133 Mhz.
 

So now i am wondering whether /proc is given me the
wrong information of its a limitation of the kernel
that it cant recognise e1000 driver.Currently i am
using the 2.4.18 kernel and am wondering if this
chipset support is available in linux kernel? 

Given the slightest hint i am willing to work on it to
find out the solution; Any help will be greatly
appreciated.Please cc: me the answers /suggestions
since i am not on the list

Thanking all

abhishek Sinha

___

__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
