Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVJWSha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVJWSha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJWSh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:37:29 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:16631
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S1750825AbVJWSh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:37:29 -0400
Message-ID: <435BD860.7060604@ev-en.org>
Date: Sun, 23 Oct 2005 19:37:20 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ning Jiang <njiang@cs.ucf.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 TCP persist mode
References: <Pine.GSO.4.61.0510231333380.11021@eola.cs.ucf.edu>
In-Reply-To: <Pine.GSO.4.61.0510231333380.11021@eola.cs.ucf.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ning Jiang wrote:
> Hi, all,
> 
> I'm testing some programs on Linux 2.4.20. My programs The programs work
> as follows:
> 
> 1. A TCP Server is listening on a machine.
> 2. A TCP Client connects the server.
> 3. The TCP server transmits 3000 packets to the client.
> 4. A netfilter hook is registered on the same machine as the TCP server.
> The hook inspects the incoming ACKs. For some ACK, the hook function
> changes the acknowledge window size to 0. Suppose the acknowledgement
> sequence of the ACK is N, the hook function sets it to a value N' (N' <
> N).  The purpose is to switch TCP into persist mode, where TCP ceases
> transmitting data packets to the receiver, and periodically probe the
> reciever until an ACK with non zero ack window is received.
> 
> Our observation is: when we set N'<N, the 2.4.20 kernel didn't switch
> into persist mode! It tried to retransmit the previous packet. When we
> set N'=N, it did switch into persist mode. It seems that TCP of 2.4.20
> will only switch into persist mode when the whole window of segments are
> successfully acknowledged. Otherwise, it will simply retransmit the
> segments.
> 
> Anyone knows this problem? Any idea on how to switch TCP into persist
> mode without acknowledging the whole window boundary?

It sounds like this is the correct behaviour. The window obviously was
open at the time the packets were sent and if we get now a window of
zero it just means that the window is closed now and we can't send
anything new. If there are packets that weren't acknowledged we should
retransmit them.

Baruch
