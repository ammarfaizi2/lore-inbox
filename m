Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131159AbQLZBSI>; Mon, 25 Dec 2000 20:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbQLZBRr>; Mon, 25 Dec 2000 20:17:47 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:33804 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S131453AbQLZBR0>; Mon, 25 Dec 2000 20:17:26 -0500
Date: Mon, 25 Dec 2000 22:46:54 -0200
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001225224654.A2080@flower.cesarb>
In-Reply-To: <20001223223814.A2281@flower.cesarb> <NCBBLIEPOCNJOAEKBEAKOEDJMKAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKOEDJMKAA.davids@webmaster.com>; from davids@webmaster.com on Mon, Dec 25, 2000 at 04:33:07PM -0800
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 04:33:07PM -0800, David Schwartz wrote:
> 
> > On Sat, Dec 23, 2000 at 04:19:31PM -0800, David Schwartz wrote:
> 
> > > > This means that keepalive is useless for keeping alive more than
> > > > one connection
> > > > to a given host.
> 
> > > 	Actually, keepalive is useless for keeping connections
> > > alive anyway. It's
> > > very badly named. It's purpose is to detect dead peers, not keep peers
> > > alive.
> >
> > Then what do you do when you are behind a NAT?
> 
> 	If the administrator of the NAT meant for you to have a permanent mapping,
> she would have put one there. Using keepalives to hold a NAT entry open
> indefinitely without activity would be considered abuse in most NAT
> configurations. The NAT might not consider a keepalive to be activity anyway
> (arguably, it shouldn't).

Well, consider the scenario of an application which opens a control connection
and a data connection, and the data connection remains idle for some hours
while you get to the beginning of the queue, and then the transfer starts. The
data connection is not open forever, and the timeout (and the periodic pings)
is on the control connection.

The problem is that, after four or more hours of waiting, when the other side
finally starts sending, the NAT has already forgotten about the connection.

(In case someone is wondering, the application I'm talking about is fidelio.
 Which is pretty useless on busy sites behind a NAT because of that.)

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
