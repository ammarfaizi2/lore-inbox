Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLTRye>; Wed, 20 Dec 2000 12:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLTRyY>; Wed, 20 Dec 2000 12:54:24 -0500
Received: from Cantor.suse.de ([194.112.123.193]:62737 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129352AbQLTRyJ>;
	Wed, 20 Dec 2000 12:54:09 -0500
Date: Wed, 20 Dec 2000 18:23:39 +0100
From: Andi Kleen <ak@suse.de>
To: Cord Seele <Seele@emlix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getsockopt() with IP_PKTINFO not working?
Message-ID: <20001220182339.A17520@gruyere.muc.suse.de>
In-Reply-To: <3A40E1F2.2C8E0127@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A40E1F2.2C8E0127@emlix.com>; from Seele@emlix.com on Wed, Dec 20, 2000 at 05:44:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 05:44:34PM +0100, Cord Seele wrote:
> I am trying to get the destination address of an incoming udp packet
> with getsockopt().
> According to the man pages flag IP_PKTINFO should do that. But it
> doesn't work:
> 
>         struct in_pktinfo pktinfo;
>         socklen_t optlen;
>         struct in_addr local_addr;
> 
>         optlen=(socklen_t)sizeof(pktinfo);   
>         syslog (LOG_ERR, "ERR %d",           
>           getsockopt(fd, SOL_IP, IP_PKTINFO, &pktinfo, &optlen));

You're misreading the manpage. IP_PKTINFO just enables recvmsg() to pass
ancillary messages that contain pktinfo structures. getsockopt IP_PKTINFO
returns the state of the the IP_PKTINFO flag on the socket.

So use setsockopt IP_PKTINFO to set the flag to true and then receive
them using recvmsg().

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
