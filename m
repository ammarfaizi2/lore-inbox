Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132966AbRAVSof>; Mon, 22 Jan 2001 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRAVSoZ>; Mon, 22 Jan 2001 13:44:25 -0500
Received: from palrel1.hp.com ([156.153.255.242]:32521 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S132966AbRAVSoQ>;
	Mon, 22 Jan 2001 13:44:16 -0500
Message-ID: <3A6C7F7D.52DA2AFC@cup.hp.com>
Date: Mon, 22 Jan 2001 10:44:13 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <200101201803.VAA04679@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> >                                                       is there really
> > much value in the second request flowing to the server before the first
> > byte of the reply has hit?
> 
> Yes, of course, it has lots of sense: f.e. all the icons, referenced
> parent page are batched to single well-coalesced stream without rtt delays
> between them. It is the only sense of pipelining yet.

"Elsewhere" i see references stating that the typical RTT for the great
unwashed masses is somewhere in the range of 100 to 200 milliseconds.

The linux standalone ACK timer is 200 milliseconds yes?

If the web server is going to take longer than 200 milliseconds to
generate the first byte of the reply to the first request it seems that
the bottleneck here is the web server, not the link RTT.

Now, if the server _is_ able to respond with the first bytes (ignoring
CORK for the moment) sooner than the standalone ACK timer, then perhaps
the RTT is an issue. However, as we were in the constrained case of only
two requests, I suspect that it is not a big deal.

If there are all those icons to be displayed, there would be more than
two requests. Without the explicit (cork et al)/implicit (tcpnodely)
push at the client those 2-N requests will pile-up into a nice sized TCP
segment. Those requests will arrive en-mass at the server and will then
have RTT issues ammortized.

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
