Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132981AbRANSvS>; Sun, 14 Jan 2001 13:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133020AbRANSvI>; Sun, 14 Jan 2001 13:51:08 -0500
Received: from chiara.elte.hu ([157.181.150.200]:3600 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132981AbRANSuz>;
	Sun, 14 Jan 2001 13:50:55 -0500
Date: Sun, 14 Jan 2001 19:50:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101141945520.3103-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2001, jamal wrote:

> regular ttcp, no ZC and no sendfile. [...]
> Throughput: ~99MB/sec (for those obsessed with Mbps ~810Mbps)
> CPU abuse: server side 87% client side 22% [...]

> sendfile server.
> - throughput: 86MB/sec
> - CPU: server 100%, client 17%

i believe what you are seeing here is the overhead of the pagecache. When
using sendmsg() only, you do not read() the file every time, right? Is
ttcp using multiple threads? In that case if the sendfile() is using the
*same* file all the time, creating SMP locking overhead.

if this is the case, what result do you get if you use a separate,
isolated file per process? (And i bet that with DaveM's pagecache
scalability patch the situation would also get much better - the global
pagecache_lock hurts.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
