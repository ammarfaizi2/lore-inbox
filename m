Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJWRed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJWRed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJWRed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 13:34:33 -0400
Received: from longwood.cs.ucf.edu ([132.170.108.1]:38648 "EHLO
	longwood.cs.ucf.edu") by vger.kernel.org with ESMTP
	id S1750762AbVJWRec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 13:34:32 -0400
Date: Sun, 23 Oct 2005 13:34:31 -0400 (EDT)
From: Ning Jiang <njiang@cs.ucf.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.20 TCP persist mode
Message-ID: <Pine.GSO.4.61.0510231333380.11021@eola.cs.ucf.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I'm testing some programs on Linux 2.4.20. My programs The programs work 
as follows:

1. A TCP Server is listening on a machine.
2. A TCP Client connects the server.
3. The TCP server transmits 3000 packets to the client.
4. A netfilter hook is registered on the same machine as the TCP server. 
The hook inspects the incoming ACKs. For some ACK, the hook function 
changes the acknowledge window size to 0. Suppose the acknowledgement 
sequence of the ACK is N, the hook function sets it to a value N' (N' < 
N).  The purpose is to switch TCP into persist mode, where TCP ceases 
transmitting data packets to the receiver, and periodically probe the 
reciever until an ACK with non zero ack window is received.

Our observation is: when we set N'<N, the 2.4.20 kernel didn't switch into 
persist mode! It tried to retransmit the previous packet. When we set 
N'=N, it did switch into persist mode. It seems that TCP of 2.4.20 will 
only switch into persist mode when the whole window of segments are 
successfully acknowledged. Otherwise, it will simply retransmit the 
segments.

Anyone knows this problem? Any idea on how to switch TCP into persist mode 
without acknowledging the whole window boundary?

Thanks!!
