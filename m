Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTLEAaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTLEAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:30:39 -0500
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:31989 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263767AbTLEAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:30:20 -0500
Message-ID: <3FCFD1AD.40602@ameritech.net>
Date: Thu, 04 Dec 2003 18:30:37 -0600
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: devfs_mk_cdev  question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a litte perplexed.  Is this error message important?

I am running linux-2.6.0-test11 on a modified Mandrake 9.2 rc2 release.
The sound card is playing as I type but on boot I saw:
[
Dec  4 16:44:27 dali kernel: Advanced Linux Sound Architecture Driver 
Version 0.9.7 (Thu Sep 25 19:16:36 20
03 UTC).
Dec  4 16:44:27 dali kernel: request_module: failed /sbin/modprobe -- 
snd-card-0. error = -16
Dec  4 16:44:27 dali kernel: ALSA device list:
Dec  4 16:44:27 dali kernel:   No soundcards found.
]
but lsmod shows:
[
Module                  Size  Used by
snd_emu10k1            97572  -
snd_rawmidi            25408  -
snd_ac97_codec         54852  -
snd_util_mem            4704  -
snd_hwdep               9568  -
nls_cp850               4800  -
ntfs                   90188  -
tuner                  15596  -
tvaudio                22668  -
bttv                  140940  -
video_buf              22756  -
i2c_algo_bit           10280  -
btcx_risc               4808  -
evdev                  10272  -
]

As I slowly work my way through the problems I see this:
[
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/hwC0D0
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/midiC0D0
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/pcmC0D3p
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/pcmC0D2c
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/pcmC0D1c
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/pcmC0D0p
Dec  4 16:45:29 dali kernel: devfs_mk_cdev: could not append to parent 
for snd/pcmC0D0c
Dec  4 16:45:29 dali modprobe: FATAL: Module /dev/sound/mixer1 not found.
Dec  4 16:45:29 dali modprobe: FATAL: Module /dev/sound/mixer1 not found.
]

So I do a:

"tree /sys/class" and see:
[
/sys/class
|-- i2c-adapter
|   `-- i2c-0
|       |-- device -> ../../../devices/pci0000:00/0000:00:0b.0/i2c-0
|       `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
|-- i2c-dev
|   `-- i2c-0
|       |-- dev
|       |-- device -> ../../../devices/pci0000:00/0000:00:0b.0
|       `-- driver -> ../../../bus/pci/drivers/bttv
|-- input
|-- net
|   |-- eth0
|   |   |-- addr_len
|   |   |-- address
|   |   |-- broadcast
|   |   |-- device -> ../../../devices/pci0000:00/0000:00:09.0
|   |   |-- driver -> ../../../bus/pci/drivers/e100
|   |   |-- features
|   |   |-- flags
|   |   |-- ifindex
|   |   |-- iflink
|   |   |-- mtu
|   |   |-- statistics
|   |   |   |-- collisions
|   |   |   |-- multicast
|   |   |   |-- rx_bytes
|   |   |   |-- rx_compressed
|   |   |   |-- rx_crc_errors
|   |   |   |-- rx_dropped
|   |   |   |-- rx_errors
|   |   |   |-- rx_fifo_errors
|   |   |   |-- rx_frame_errors
|   |   |   |-- rx_length_errors
|   |   |   |-- rx_missed_errors
|   |   |   |-- rx_over_errors
|   |   |   |-- rx_packets
|   |   |   |-- tx_aborted_errors
|   |   |   |-- tx_bytes
|   |   |   |-- tx_carrier_errors
|   |   |   |-- tx_compressed
|   |   |   |-- tx_dropped
|   |   |   |-- tx_errors
|   |   |   |-- tx_fifo_errors
|   |   |   |-- tx_heartbeat_errors
|   |   |   |-- tx_packets
|   |   |   `-- tx_window_errors
|   |   |-- tx_queue_len
|   |   `-- type
|   `-- lo
|       |-- addr_len
|       |-- address
|       |-- broadcast
|       |-- features
|       |-- flags
|       |-- ifindex
|       |-- iflink
|       |-- mtu
|       |-- statistics
|       |   |-- collisions
|       |   |-- multicast
|       |   |-- rx_bytes
|       |   |-- rx_compressed
|       |   |-- rx_crc_errors
|       |   |-- rx_dropped
|       |   |-- rx_errors
|       |   |-- rx_fifo_errors
|       |   |-- rx_frame_errors
|       |   |-- rx_length_errors
|       |   |-- rx_missed_errors
|       |   |-- rx_over_errors
|       |   |-- rx_packets
|       |   |-- tx_aborted_errors
|       |   |-- tx_bytes
|       |   |-- tx_carrier_errors
|       |   |-- tx_compressed
|       |   |-- tx_dropped
|       |   |-- tx_errors
|       |   |-- tx_fifo_errors
|       |   |-- tx_heartbeat_errors
|       |   |-- tx_packets
|       |   `-- tx_window_errors
|       |-- tx_queue_len
|       `-- type
|-- scsi_device
|-- scsi_host
|-- tty
|   |-- console
|   |   `-- dev
|   |-- ptmx
|   |   `-- dev
|   |-- tty
|   |   `-- dev
|   |-- tty0
|   |   `-- dev
|   |-- tty1
|   |   `-- dev
|   |-- tty10
|   |   `-- dev
|   |-- tty11
|   |   `-- dev
|   |-- tty12
|   |   `-- dev
|   |-- tty13
|   |   `-- dev
|   |-- tty14
|   |   `-- dev
|   |-- tty15
|   |   `-- dev
|   |-- tty16
|   |   `-- dev
|   |-- tty17
|   |   `-- dev
|   |-- tty18
|   |   `-- dev
|   |-- tty19
|   |   `-- dev
|   |-- tty2
|   |   `-- dev
|   |-- tty20
|   |   `-- dev
|   |-- tty21
|   |   `-- dev
|   |-- tty22
|   |   `-- dev
|   |-- tty23
|   |   `-- dev
|   |-- tty24
|   |   `-- dev
|   |-- tty25
|   |   `-- dev
|   |-- tty26
|   |   `-- dev
|   |-- tty27
|   |   `-- dev
|   |-- tty28
|   |   `-- dev
|   |-- tty29
|   |   `-- dev
|   |-- tty3
|   |   `-- dev
|   |-- tty30
|   |   `-- dev
|   |-- tty31
|   |   `-- dev
|   |-- tty32
|   |   `-- dev
|   |-- tty33
|   |   `-- dev
|   |-- tty34
|   |   `-- dev
|   |-- tty35
|   |   `-- dev
|   |-- tty36
|   |   `-- dev
|   |-- tty37
|   |   `-- dev
|   |-- tty38
|   |   `-- dev
|   |-- tty39
|   |   `-- dev
|   |-- tty4
|   |   `-- dev
|   |-- tty40
|   |   `-- dev
|   |-- tty41
|   |   `-- dev
|   |-- tty42
|   |   `-- dev
|   |-- tty43
|   |   `-- dev
|   |-- tty44
|   |   `-- dev
|   |-- tty45
|   |   `-- dev
|   |-- tty46
|   |   `-- dev
|   |-- tty47
|   |   `-- dev
|   |-- tty48
|   |   `-- dev
|   |-- tty49
|   |   `-- dev
|   |-- tty5
|   |   `-- dev
|   |-- tty50
|   |   `-- dev
|   |-- tty51
|   |   `-- dev
|   |-- tty52
|   |   `-- dev
|   |-- tty53
|   |   `-- dev
|   |-- tty54
|   |   `-- dev
|   |-- tty55
|   |   `-- dev
|   |-- tty56
|   |   `-- dev
|   |-- tty57
|   |   `-- dev
|   |-- tty58
|   |   `-- dev
|   |-- tty59
|   |   `-- dev
|   |-- tty6
|   |   `-- dev
|   |-- tty60
|   |   `-- dev
|   |-- tty61
|   |   `-- dev
|   |-- tty62
|   |   `-- dev
|   |-- tty63
|   |   `-- dev
|   |-- tty7
|   |   `-- dev
|   |-- tty8
|   |   `-- dev
|   |-- tty9
|   |   `-- dev
|   |-- ttyS0
|   |   `-- dev
|   |-- ttyS1
|   |   `-- dev
|   |-- ttyS2
|   |   `-- dev
|   |-- ttyS3
|   |   `-- dev
|   |-- ttyS4
|   |   `-- dev
|   |-- ttyS5
|   |   `-- dev
|   |-- ttyS6
|   |   `-- dev
|   `-- ttyS7
|       `-- dev
|-- usb
|-- usb_host
|   `-- usb1
|       |-- device -> ../../../devices/pci0000:00/0000:00:07.2
|       `-- driver -> ../../../bus/pci/drivers/uhci_hcd
`-- video4linux
     |-- vbi0
     |   |-- dev
     |   |-- device -> ../../../devices/pci0000:00/0000:00:0b.0
     |   |-- driver -> ../../../bus/pci/drivers/bttv
     |   `-- name
     `-- video0
         |-- card
         |-- dev
         |-- device -> ../../../devices/pci0000:00/0000:00:0b.0
         |-- driver -> ../../../bus/pci/drivers/bttv
         `-- name
]



