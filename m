Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317614AbSFIOsH>; Sun, 9 Jun 2002 10:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSFIOsG>; Sun, 9 Jun 2002 10:48:06 -0400
Received: from evil.netppl.fi ([195.242.209.201]:5849 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id <S317614AbSFIOsF>;
	Sun, 9 Jun 2002 10:48:05 -0400
Date: Sun, 9 Jun 2002 17:47:40 +0300
From: Pekka =?iso-8859-15?Q?Pietik=E4inen?= <Pekka.Pietikainen@nixu.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020609144740.GA7805@netppl.fi>
In-Reply-To: <3CFFB9F8.54455B6E@nortelnetworks.com> <20020606.202108.52904668.davem@redhat.com> <3D01307C.4090503@candelatech.com> <20020608170511.B26821@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 05:05:11PM -0400, Mark Mielke wrote:
> Datagram sockets are more straight forward to implement this for, but
> that does not mean that TCP/IP does not have similar potential.
> 
> I am not certain what the exact requirement is for in Chris' cases,
> but I do know that in his field, he is writing something far more
> complicated and resource intensive than a telnet server.
Have you guys checked out if the TCP_INFO getsockopt() would 
work for your needs? (obviously, it'll only work for TCP connections
). It gives you quite a bit of detail about what's happening 
in your TCP connection (retransmissions, window sizes etc.).

  printf("unacked: %d sacked: %d lost: %d retrans: %d fackets: %d\n",
                info.tcpi_unacked,info.tcpi_sacked,info.tcpi_lost,
                info.tcpi_retrans,info.tcpi_fackets);
  printf("pmtu: %d rcv_ssthresh: %d rtt: %d rttvar: %d snd_ssthresh:
%d\nsnd_cwnd: %d advmss:
%d reordering: %d\n",info.tcpi_pmtu,info.tcpi_rcv_ssthresh,
	 info.tcpi_rtt,info.tcpi_rttvar,info.tcpi_snd_ssthresh,info.tcpi_snd_cwnd,info.tcpi_advmss,
         info.tcpi_reordering);

-- 
M.Sc. (Eng.) Pekka Pietikainen, Nixu Oy




