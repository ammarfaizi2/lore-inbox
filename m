Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWCHKDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWCHKDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCHKDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:03:34 -0500
Received: from igate.tek.com ([192.65.41.20]:13631 "EHLO igate.tek.com")
	by vger.kernel.org with ESMTP id S932544AbWCHKDe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:03:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.16-rc5: Slab corruption in usbserial when disconnecting device
Date: Wed, 8 Mar 2006 10:03:19 -0000
Message-ID: <8BE19BC613681046A50B3FD0DCC996CD01D4220F@eu-brac-m51.global.tektronix.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: Slab corruption in usbserial when disconnecting device
Thread-Index: AcZCl4bDL9VnIScHSa2guH9CIsU1iA==
From: <pete.chapman@exgate.tek.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 10:03:21.0300 (UTC) FILETIME=[87D4C140:01C64297]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I saw a slab corruption message in my log files after disconnecting a
USB Serial device (a Crystalfontz CFA-635 LCD panel). I have included
surrounding log lines from the smbd service because I suspect that the
corruption may have caused it some trouble. The kernel is Mandriva's
x86_64 2.6.16-rc5.13mdksmp.

Mar  7 10:17:46 localhost smbd[9187]: [2006/03/07 10:17:46, 0]
smbd/service.c:make_connection(794)
Mar  7 10:17:46 localhost smbd[9187]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:17:52 localhost smbd[9187]: [2006/03/07 10:17:52, 0]
smbd/service.c:make_connection(794)
Mar  7 10:17:52 localhost smbd[9187]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:18:31 localhost smbd[9134]: [2006/03/07 10:18:31, 0]
smbd/service.c:make_connection(794)
Mar  7 10:18:31 localhost smbd[9134]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:18:31 localhost smbd[9134]: [2006/03/07 10:18:31, 0]
smbd/service.c:make_connection(794)
Mar  7 10:18:31 localhost smbd[9134]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:18:33 localhost smbd[9134]: [2006/03/07 10:18:33, 0]
smbd/service.c:make_connection(794)
Mar  7 10:18:33 localhost smbd[9134]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:18:48 localhost smbd[9602]: [2006/03/07 10:18:48, 0]
lib/util_sock.c:read_socket_data(384)
Mar  7 10:18:48 localhost smbd[9602]:   read_socket_data: recv failure
for 4. Error = Connection reset by peer
Mar  7 10:18:57 localhost kernel: ftdi_sio ttyUSB0: FTDI USB Serial
Device converter now disconnected from ttyUSB0
Mar  7 10:18:58 localhost kernel: Slab corruption:
start=ffff81021d9299e8, len=1024
Mar  7 10:18:58 localhost kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Mar  7 10:18:58 localhost kernel: Last user:
[_end+131701853/2132033536](port_release+0xd5/0xda [usbserial])
Mar  7 10:18:58 localhost kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6c 6b 6b
6b 6b 6b 6b 6b
Mar  7 10:18:58 localhost kernel: Prev obj: start=ffff81021d9295d0,
len=1024
Mar  7 10:18:58 localhost kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Mar  7 10:18:58 localhost kernel: Last user:
[skb_release_data+154/159](skb_release_data+0x9a/0x9f)
Mar  7 10:18:58 localhost kernel: Last user:
[<ffffffff80298a51>](skb_release_data+0x9a/0x9f)
Mar  7 10:18:58 localhost kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b 6b 6b
Mar  7 10:18:58 localhost kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b 6b 6b
Mar  7 10:19:10 localhost smbd[9725]: [2006/03/07 10:19:10, 0]
lib/util_sock.c:get_peer_addr(1150)
Mar  7 10:19:10 localhost smbd[9725]:   getpeername failed. Error was
Transport endpoint is not connected
Mar  7 10:19:10 localhost smbd[9725]: [2006/03/07 10:19:10, 0]
lib/util_sock.c:write_socket_data(430)
Mar  7 10:19:10 localhost smbd[9725]:   write_socket_data: write
failure. Error = Connection reset by peer
Mar  7 10:19:10 localhost smbd[9725]: [2006/03/07 10:19:10, 0]
lib/util_sock.c:write_socket(455)
Mar  7 10:19:10 localhost smbd[9725]:   write_socket: Error writing 4
bytes to socket 24: ERRNO = Connection reset by peer
Mar  7 10:19:10 localhost smbd[9725]: [2006/03/07 10:19:10, 0]
lib/util_sock.c:send_smb(647)
Mar  7 10:19:10 localhost smbd[9725]:   Error writing 4 bytes to client.
-1. (Connection reset by peer)
Mar  7 10:19:17 localhost smbd[9736]: [2006/03/07 10:19:17, 0]
lib/util_sock.c:read_socket_data(384)
Mar  7 10:19:17 localhost smbd[9736]:   read_socket_data: recv failure
for 4. Error = Connection reset by peer
Mar  7 10:19:23 localhost smbd[9737]: [2006/03/07 10:19:23, 0]
smbd/service.c:make_connection(794)
Mar  7 10:19:23 localhost smbd[9737]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:19:24 localhost smbd[9737]: [2006/03/07 10:19:24, 0]
smbd/service.c:make_connection(794)
Mar  7 10:19:24 localhost smbd[9737]:   kishore (192.168.118.145)
couldn't find service c$
Mar  7 10:19:25 localhost smbd[9737]: [2006/03/07 10:19:25, 0]
smbd/service.c:make_connection(794)
Mar  7 10:19:25 localhost smbd[9737]:   kishore (192.168.118.145)
couldn't find service c$
