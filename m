Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQLXOnY>; Sun, 24 Dec 2000 09:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbQLXOnO>; Sun, 24 Dec 2000 09:43:14 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:17668 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129781AbQLXOm6>; Sun, 24 Dec 2000 09:42:58 -0500
Date: Sun, 24 Dec 2000 12:12:28 -0200
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001224121228.A340@flower.cesarb>
In-Reply-To: <20001223213156.A1947@flower.cesarb> <20001224101455.A11662@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001224101455.A11662@gruyere.muc.suse.de>; from ak@suse.de on Sun, Dec 24, 2000 at 10:14:55AM +0100
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 10:14:55AM +0100, Andi Kleen wrote:
> On Sat, Dec 23, 2000 at 09:31:56PM -0200, Cesar Eduardo Barros wrote:
> > 
> > I've been doing some experiments with the keepalive code in 2.4.0-test10 here
> > (I want to avoid the 2.2.x NAT I'm using (for which I don't have root) from
> >  timing out my connections). To test it, I reduced both tcp_keepalive_time and
> > tcp_keepalive_intvl to 1. Using ethereal, I saw that the keepalives were sent
> > as expected, but only for one of the two idle TCP connections I had to a given
> > host (I was testing with two remote hosts, each with two idle TCP connections,
> > one in port 5500 and the other in port 5501). I only saw activity on 5500, yet
> > netstat told me both were still active.
> 
> I just tried it and it works fine here with 2.4.0-test13-pre
> 
> You should be aware that the sysctls are only picked up after a timer timeout
> or when a socket is newly created. When the sockets are already active it
> takes a timeout for them to take effect. The default timeout is 2 hours.
> 

I noticed that, so I exited the program and reloaded it after each change. I
still don't know why it worked only with the first socket here (both sockets
are opened by the same program). Maybe something changed in the networking code
since test10?

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
