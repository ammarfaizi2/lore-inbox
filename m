Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAZSJf>; Fri, 26 Jan 2001 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbRAZSJZ>; Fri, 26 Jan 2001 13:09:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:55563 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129562AbRAZSJO>;
	Fri, 26 Jan 2001 13:09:14 -0500
Date: Fri, 26 Jan 2001 19:08:56 +0100
From: Andi Kleen <ak@suse.de>
To: Martin Rauh <martin.rauh@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Packet loss in IP/UDP Stack?
Message-ID: <20010126190856.A19098@gruyere.muc.suse.de>
In-Reply-To: <3A71BB68.21B998AB@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A71BB68.21B998AB@gmx.de>; from martin.rauh@gmx.de on Fri, Jan 26, 2001 at 07:01:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 07:01:12PM +0100, Martin Rauh wrote:
> Hi folks,
> 
> It seems that we are loosing packets in the UDP stack.
> Somebody might think that this is not astonishing, but
> the packets are not lost at the network layer. They seem to get
> lost in the IP/UDP Layer of the receiving box.
> 
> We have got the following configuration:
> Two linux boxes (P4, 733 MHz, 256 MB RAM, kernel 2.4.0)
> are directly connected with two syskonnect sk98xx
> gigabit ethernet cards. We are sending a file from one host to the other
> 
> with UDP. About half of the file is lost in the receiving application.
> But according to the statistics in /proc/net/dev no errors (fifo, frame,
> dropped...)
> occured in the network layer. Even the transmitted and received
> data at the network layer (tx-bytes, -packets) are identical
> to the amount of the transfered file (plus network overhead).
> 
> Doas anybody know where the loss occurs? Is there a loss at the
> network layer or in the higher protocol layers?
 
UDP by default has 64K buffer and drops packets when it overflows.
You can check that using netstat -s. 
You can increase it use the SO_{SND,RCV}BUF socket options and/or the 
net/core/[rw]mem_* sysctls.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
