Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbTGVGLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269616AbTGVGLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:11:46 -0400
Received: from evil.netppl.fi ([195.242.209.201]:29141 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S269612AbTGVGLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:11:45 -0400
Date: Tue, 22 Jul 2003 09:26:44 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: yi <yi@ece.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP congestion window
Message-ID: <20030722062644.GA18791@netppl.fi>
References: <3F1C6406.5040009@ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3F1C6406.5040009@ece.utexas.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:07:02PM -0500, yi wrote:
> I have some questions. I made the following system call for getting tcp 
> cwnd size of ongoing connection. However, I am always getting the value 
> of "2", which is the initial tcp cwnd size, I think. What I really want 
> to do is to trace tcp cwnd size when I download some big file using 
> "wget"'s http file downloader. For it, I added a new system call shown 
> below and modified the wget source code.
Also what you want already exists, so no need to modify the kernel,
the TCP_INFO socket option (netinet/tcp.h should have the required
definitions in recent glibc)

  struct tcp_info info;
  int optlen=sizeof(struct tcp_info);
  if(getsockopt(sk->fd,SOL_TCP,TCP_INFO,(void *)&info,&optlen) < 0)
    return;
  printf("unacked: %d sacked: %d lost: %d retrans: %d fackets: %d\n",
                info.tcpi_unacked,info.tcpi_sacked,info.tcpi_lost,
                info.tcpi_retrans,info.tcpi_fackets);
  printf("pmtu: %d rcv_ssthresh: %d rtt: %d rttvar: %d snd_ssthresh:
	%d\nsnd_cwnd: %d advmss: %d reordering: %d\n",info.tcpi_pmtu,info.tcpi_rcv_ssthresh,
  info.tcpi_rtt,info.tcpi_rttvar,info.tcpi_snd_ssthresh,info.tcpi_snd_cwnd,info.tcpi_advmss,
          info.tcpi_reordering)

There's a few more that I don't print there, see the header file.

-- 
Pekka Pietikainen




