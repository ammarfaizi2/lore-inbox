Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131222AbRARSUr>; Thu, 18 Jan 2001 13:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131356AbRARSUh>; Thu, 18 Jan 2001 13:20:37 -0500
Received: from palrel3.hp.com ([156.153.255.226]:38157 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S131222AbRARSUX>;
	Thu, 18 Jan 2001 13:20:23 -0500
Message-ID: <3A6733E0.6286A388@cup.hp.com>
Date: Thu, 18 Jan 2001 10:20:16 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101171259470.10031-100000@penguin.transmeta.com> <3A661A00.E3344A18@cup.hp.com> <20010118103414.A18205@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Wed, Jan 17, 2001 at 02:17:36PM -0800, Rick Jones wrote:
> > How does CORKing interact with ACK generation? In particular how it
> > might interact with (or rather possibly induce) standalone ACKs?
> 
> It doesn't change the ACK generation. If your cork'ed packets gets sent
> before the delayed ack triggers it is piggy backed, if not it is send
> individually. When the delayed ack triggers depends; Linux has dynamic
> delack based on the rtt and also a special quickack mode to speed up slow
> start.

So if I understand  all this correctly...

The difference in ACK generation would be that with nagle it is a race
between the standalone ack heuristic and the first byte of response
data, with cork, the race is between the standalone ack heuristic and
the last byte of response data and an uncork call, or the MSSth byte
whichever comes first.

If the response bytes are dribbling slowly into the socket, where slowly
is less than the bandwidth delay product of the connection, cork can
result in quite fewer packets than nagle would. It would perhaps though
have one more standalone ACK than nagle

If the response bytes are dribbling quickly into the socket, where
quickly is greater than the bandwidth delay product of the connection,
cork will produce one less packet than nagle.

If the response bytes go into the socket together, cork and nagle will
produce the same number of packets.

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
