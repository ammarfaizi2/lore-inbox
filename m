Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSLBSzQ>; Mon, 2 Dec 2002 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLBSzQ>; Mon, 2 Dec 2002 13:55:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:5065 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264857AbSLBSzO>;
	Mon, 2 Dec 2002 13:55:14 -0500
Message-ID: <3DEBACEE.200EF7A9@us.ibm.com>
Date: Mon, 02 Dec 2002 10:56:47 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: trog@wincom.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [MAY-BE-OT] Slow FTP Transfers between 2.4 machines
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This _might_ be OT... certainly I'm not entirely ready to lay this at the feet
> of the kernel just yet. Any pointers to troubleshooting documents would be _greatly_
> appreciated.

linux-net@vger.kernel.org would be a more appropriate mailing list..

> FTP from either box to a decent server via the cable modem may go as high as
> 250-ish k/sec. FTP transfers from box to box start out at ~ 100k/sec and very
> quickly (3sec) drop to a stable 42 k/sec which persists for the rest of the
> transfer, independant of which box is server or client.
> 
> Both boxes are using vsftpd behind xinetd, vsftpd manual was RTFMed and I'm
> pretty sure this isn't a userspace-daemon-throttling thing (although some form
> of verification that this is the case would be nice)

what are your sysctl settings, especially your buffer sizes? Increasing 
your default tcp buffer size is the single most useful thing you can do
to improve performance if your app doesnt set buffer sizes using 
setsockopt (and I dont believe it does). does it use TCP_NODELAY?  are
you using ipsec?

are you sure you have path mtu turned on? is fragmentation occuring?
netstat -s would show you the snmp and tcp extended stats - that would
be the first place to look for problems..

> ifconfig/proc reports show no collisions or other errors to speak of. CPU remains
> near-idle on both boxes during transfers. The TX/RX lights on the hub are "leisurely"
> - the transfers don't look like a constrant stream, but rather more like regular
> bursts of activity. 
> 
> I can find no evidence of errors or of anything wrong anywhere, aside from the
> transfers being slow, and that telnet sessions from one box to the other get
> choppy and laggy during large transfers. Once the transfer is completed, responsiveness
> returns to normal.
> 
> Pointers to trobleshooting documents would be greatly appreciated. I have had
> little luck finding anything on my own.

a tcpdump trace would be the next thing to look at - that should tell you
whats happening (although perhaps not why :))

thanks,
Nivedita
