Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263259AbSJFBAk>; Sat, 5 Oct 2002 21:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbSJFBAk>; Sat, 5 Oct 2002 21:00:40 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1664 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263259AbSJFBAi> convert rfc822-to-8bit; Sat, 5 Oct 2002 21:00:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: [BENCHMARK] contest 0.50 results to date
Date: Sun, 6 Oct 2002 11:03:27 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, rmaureira@alumno.inacap.cl,
       rcastro@ime.usp.br
References: <20021005182850.31930.qmail@linuxmail.org> <3D9F3A52.4FB46701@digeo.com>
In-Reply-To: <3D9F3A52.4FB46701@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210061103.35105.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 06 Oct 2002 5:15 am, Andrew Morton wrote:
> Paolo Ciarrocchi wrote:
> > And here are my results:
> I think I'm going to have to be reminded what "Loads" and "LCPU"
> mean, please.

Loads for process_load is the number of iterations each load manages to 
succeed doing divided by 10000. Loads for mem_load is the number of times 
mem_load manages to access the ram divided by 1000. Loads for io_load is the 
approximate number of megabytes divided by 100 it writes during the kernel 
compile.  The denominator for loads was chosen to easily represent the data, 
and also correlates well with significant digits.

LCPU% is the load's cpu% usage while it is running. The load is started 3 
seconds before the kernel compile and takes a variable length of time to 
finish, so it can be more than 100-cpu%

> For these sorts of tests, I think system-wide CPU% is an interesting
> thing to track - both user and system.  If it is high then we're doing
> well - doing real work.

So total cpu% being used during the kernel compile? The cpu% + lcpu% should be 
very close to this.  However I'm not sure of the most accurate way to find 
out average total cpu% used during just the kernel compile - suggestion?

> The same isn't necessarily true of the compressed-cache kernel, because
> it's doing extra work in-kernel, so CPU load comparisons there need
> to be made with some caution.

That is clear, and also the reason I have a measure of work done by the load 
as well as just the lcpu% (which by itself is not very helpful).

> Apart from observing overall CPU occupancy, we also need to monitor
> fairness - one way of doing that is to measure the total kernel build
> elapsed time.  Another way would be to observe how much actual progress
> the streaming IO makes during the kernel build.

I believe that is what I'm already showing with the time for each load == 
kernel build time, and loads==io work done.

> What is "2.4.19-0.24pre4"?

Latest version of compressed cache. Note that in my testing of cc I used the 
optional LZO compression.

> I'd suggest that more tests be added.  Perhaps
>
> - one competing streaming read
>
> - several competing streaming reads
>
> - competing "tar cf foo ./linux"
>
> - competing "tar xf foo"
>
> - competing "ls -lR > /dev/null"
>

Sure, adding loads is easy enough. Just exactly what to add I wasn't sure 
about. I'll give those a shot soon.

> It would be interesting to test -aa kernels as well - Andrea's kernels
> tend to be well tuned.

Where time permits sure.

Regards,
Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9n4viF6dfvkL3i1gRArn8AJ9c+jKc/CMPxV0GWaXbVJasmBNX5QCghVYX
dbvST9mdltwuwmqEk0HHXYY=
=pcOu
-----END PGP SIGNATURE-----
