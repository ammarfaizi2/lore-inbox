Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266603AbRGEBuB>; Wed, 4 Jul 2001 21:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266604AbRGEBtw>; Wed, 4 Jul 2001 21:49:52 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:26825 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S266603AbRGEBtn>; Wed, 4 Jul 2001 21:49:43 -0400
Date: Thu, 5 Jul 2001 13:49:33 +1200 (NZST)
From: <kern@wolf.ericsson.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: tcp stack tuning and Checkpoint FW1 & Legato Networker
Message-ID: <Pine.LNX.4.33.0107051331190.2882-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone point me to a document that describes how to tune the tcp
stack for Linux kernels 2.4.x and 2.2.x

I want to set the tcp_keepalive timer to 60 seconds and understand
possible implications for Linux.

Simply I have a problem with Checkpoint FW1 and Legato Backup:

When making a backup over a Checkpoint FW from Linux using Legato on a
Solaris Server.

When legoto starts to make a backup it opens a tcp connection from the
backup client to the backup server with a standard tcp threeway
handshake.  When the backup is completed (this can take a while) the
client sends 1 packet to close the connection and includes in this the
result of the backup - success/failure.

Problem is that checkpoint seem to have taken it upon themseleves to treat
a tcp established session as "tcp_start" and not honour the state unless
the connection has additional packets sent.

the initial period after tcp establishment (3way handshake)  with no
payload defaults to 60 seconds.  Once data has been sent this connection
is moved to a state table and the connection will be honoured for 3600
seconds or whatever I choose to set it to.

Because of the tcp_start timer in checkpoint any partition with a size
sufficient to make the backup take > 60 secs will fail to receive the
success/failure packet and therefore reported as Bad.

If I set the tcp_keepalive timer to 60 seconds then keepalives will keep
the connection established for the duration of the backup which could be
50 minutes for a large partition.  I can set this under solaris with ndd
tcp_keepalive_interval 60000 (ms)

Thanks
Mark


