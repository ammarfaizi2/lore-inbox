Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbUB0SGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUB0SGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:06:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:21952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263092AbUB0SFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:05:53 -0500
Date: Fri, 27 Feb 2004 10:05:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>, Alexander Viro <aviro@redhat.com>,
       "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Sysfs is too restrictive
Message-Id: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experimenting with using sysfs to manage Ethernet bridge devices
but have to conclude that sysfs is too restrictive to be useful for doing
it.  Maybe for 2.7, some of the implementation restrictions that tie kobjects 
directly to the file hierarchy can be lifted.

Here is what I want to do.  Assume there are only two kobject's related to
bridging.  The first is the class device (inside the net_device) that contains
"br0".  The other is the bridge port which represents an interface in a bridge.
The hack method of adding kobjects to create subdirectories would make the already
painful ref count issues worse.

It is too hard to get the desired directory layout without re-implementing most
of sysfs in the driver.  This is what I want, and don't have Pat to kick around
anymore.

class
`-- net
    |-- br0
    |   |-- addr_len
    |   |-- address
    |   |-- bridge
    |   |   |-- forward_delay
    |   |   |-- hello_time
    |   |   |-- id
    |   |   |-- max_age
    |   |   |-- port
    |   |   |   |-- cost
    |   |   |   |-- eth0 -> ../../../eth0
    |   |   |   |-- priority
    |   |   |   `-- stp
    |   |   `-- priority
    |   |-- broadcast
    |   |-- features
    |   |-- flags
    |   |-- ifindex
    |   |-- mtu
    |   |-- statistics
    |   |   |-- collisions
    |   |   |-- multicast
    |   |   |-- rx_bytes
    |   |   |-- rx_compressed
    |   |   |-- rx_crc_errors
    |   |   |-- rx_dropped
    |   |   |-- rx_errors
    |   |   |-- rx_fifo_errors
    |   |   |-- rx_frame_errors
    |   |   |-- rx_length_errors
    |   |   |-- rx_missed_errors
    |   |   |-- rx_over_errors
    |   |   |-- rx_packets
    |   |   |-- tx_aborted_errors
    |   |   |-- tx_bytes
    |   |   |-- tx_carrier_errors
    |   |   |-- tx_compressed
    |   |   |-- tx_dropped
    |   |   |-- tx_errors
    |   |   |-- tx_fifo_errors
    |   |   |-- tx_heartbeat_errors
    |   |   |-- tx_packets
    |   |   `-- tx_window_errors
    |   |-- tx_queue_len
    |   `-- type
    `-- eth0
        |-- addr_len
        |-- address
        |-- broadcast
        |-- device -> ../../../devices/pci0000:00/0000:00:1e.0/0000:04:04.0
        |-- driver -> ../../../bus/pci/drivers/e100
        |-- features
        |-- flags
        |-- ifindex
        |-- iflink
        |-- mtu
        |-- statistics
        |   |-- collisions
        |   |-- multicast
        |   |-- rx_bytes
        |   |-- rx_compressed
        |   |-- rx_crc_errors
        |   |-- rx_dropped
        |   |-- rx_errors
        |   |-- rx_fifo_errors
        |   |-- rx_frame_errors
        |   |-- rx_length_errors
        |   |-- rx_missed_errors
        |   |-- rx_over_errors
        |   |-- rx_packets
        |   |-- tx_aborted_errors
        |   |-- tx_bytes
        |   |-- tx_carrier_errors
        |   |-- tx_compressed
        |   |-- tx_dropped
        |   |-- tx_errors
        |   |-- tx_fifo_errors
        |   |-- tx_heartbeat_errors
        |   |-- tx_packets
        |   `-- tx_window_errors
        |-- tx_queue_len
        `-- type

8 directories, 75 files
