Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132234AbRAMH5v>; Sat, 13 Jan 2001 02:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135542AbRAMH5b>; Sat, 13 Jan 2001 02:57:31 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:32273 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132234AbRAMH52>; Sat, 13 Jan 2001 02:57:28 -0500
Date: Fri, 12 Jan 2001 23:57:27 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: khttpd beats boa with persistent patch
Message-ID: <Pine.LNX.4.30.0101122356530.30402-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a few comments...

- localhost is a meaningless benchmark.  it's useful to catch some low
hanging fruit, but it really doesn't help in the long run.

- contrast the max connection times between kHTTPd and Boa.  if that 9
second maximum for kHTTPd is any indication of its latency performance on
a real network benchmark then... it kind of sucks hard.

latency is as important, or even more important than raw throughput.
anything beyond a second or two is the point where humans start giving up
on the server.  if you study a real benchmark such as specweb99 you'll
find that if you don't have good response latency then your score is not
valid.  they actually have a minimum throughput that each connection must
meet or else it's considered an error -- it's similar to having a latency
budget, with some slight differences.

anyhow a real network benchmark might show that kHTTPd latency is actually
not as broken as this one indicates.  i'd however really hesitate to call
this a win.

btw is your CPU slow or something?  'cause istr getting numbers at least
this good from apache across localhost several years ago even under
2.0.x... and boa and khttpd should both beat apache in this.

-dean

On Fri, 12 Jan 2001, Christoph Lameter wrote:

> I applied the persistent khttpd patch + my vhost patch and now khttpd
> beats boa!!! (patch against 2.4.0 follows at the end of the message)
>
> The connection times of boa are still better but khttpd wins in transfers.
>
> Re: TUX: Way WAAAYYY too much overkill.
>
> clameter@melchi:~$ ./zb localhost /index.html -k -c 215 -n 20000
>
> ---
> Server:                 kHTTPd/0.1.6
> Doucment Length:        1666
> Concurency Level:       215
> Time taken for tests:   17.486 seconds
> Complete requests:      20000
> Failed requests:        0
> Keep-Alive requests:    20097
> Bytes transfered:       37400517
> HTML transfered:        33481602
> Requests per seconds:   1143.77
> Transfer rate:          2138.88 kb/s
>
> Connnection Times (ms)
>            min   avg   max
> Connect:     0    28  9313
> Total:      20   185  9607
> ---
>
> clameter@melchi:~$ ./zb localhost /index.html -k -c 215 -n 20000 -p 6000
>
> ---
> Server:                 Boa/0.94.8.3
> Doucment Length:        1666
> Concurency Level:       215
> Time taken for tests:   33.865 seconds
> Complete requests:      20000
> Failed requests:        0
> Keep-Alive requests:    20001
> Bytes transfered:       37882109
> HTML transfered:        33321666
> Requests per seconds:   590.58
> Transfer rate:          1118.62 kb/s
>
> Connnection Times (ms)
>            min   avg   max
> Connect:     0     2   346
> Total:     258   360   485
> ---

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
