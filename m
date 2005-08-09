Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVHIN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVHIN4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVHIN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:56:04 -0400
Received: from berkeleydata.net ([64.62.242.226]:28580 "HELO berkeleydata.net")
	by vger.kernel.org with SMTP id S964779AbVHIN4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:56:01 -0400
Message-ID: <42F8B5EC.2090204@berkeleydata.net>
Date: Tue, 09 Aug 2005 07:55:56 -0600
From: Jonathan Ellis <jonathan@berkeleydata.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: datagram queue length
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Posted a few days ago to c.os.l.networking; no replies there.)

I seem to be running into a limit of 64 queued datagrams.  This isn't a
data buffer size; varying the size of the datagram makes no difference
in the observed queue size.  If more datagrams are sent before some are
read, they are silently dropped.  (By "silently," I mean, "tcpdump
doesn't record these as dropped packets.")

This only happens when the sending and receiving processes are on
different machines, btw.

Can anyone tell me where this magic 64 number comes from, so I can
increase it?

Python demo attached.

-Jonathan

# <receive udp requests>
# start this, then immediately start the other
# _on another machine_
import socket, time

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('', 3001))

time.sleep(5)

while True:
     data, client_addr = sock.recvfrom(8192)
     print data

# <separate process to send stuff>
import socket

for i in range(200):
     sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
     sock.sendto('a' * 100, 0, ('***other machine ip***', 3001))
     sock.close()
