Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbSJEUu4>; Sat, 5 Oct 2002 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSJEUu4>; Sat, 5 Oct 2002 16:50:56 -0400
Received: from pina.terra.com.br ([200.176.3.17]:55248 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S262665AbSJEUuz>;
	Sat, 5 Oct 2002 16:50:55 -0400
Date: Sat, 5 Oct 2002 17:56:27 -0300
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Andrew Morton <akpm@digeo.com>
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, conman@kolivas.net,
       linux-kernel@vger.kernel.org, rmaureira@alumno.inacap.cl
Subject: Re: [BENCHMARK] contest 0.50 results to date
Message-ID: <20021005205627.GA1386@vinci>
References: <20021005182850.31930.qmail@linuxmail.org> <3D9F3A52.4FB46701@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9F3A52.4FB46701@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 12:15:30PM -0700, Andrew Morton wrote:
> Paolo Ciarrocchi wrote:
> > 
[snip]
> > mem_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.19 [3]              161.1   80      38      2       1.26
> > 2.4.19-0.24pre4 [3]     181.2   76      253     19      1.41
> > 2.5.40 [3]              163.0   80      34      2       1.27
> > 2.5.40-nopree [3]       161.7   80      34      2       1.26
> > 
> 
> I think I'm going to have to be reminded what "Loads" and "LCPU"
> mean, please.
> 
> For these sorts of tests, I think system-wide CPU% is an interesting
> thing to track - both user and system.  If it is high then we're doing
> well - doing real work.
> 
> The same isn't necessarily true of the compressed-cache kernel, because
> it's doing extra work in-kernel, so CPU load comparisons there need
> to be made with some caution.

Agreed. 

I guess the scheduling is another important point here. Firstly, this
extra work, usually not substantial, may change a little the
scheduling in the system.

Secondly, given that compressed cache usually reduces the IO performed
by the system, it may change the scheduling depending on how much IO
it saves and on what the applications do. For example, mem_load
doesn't swap any page when compressed cache is enabled (those data are
highly compressible), turning out to use most of its CPU time
slice. In vanilla, mem_load is scheduled all the time to service page
faults.

-- 
Rodrigo


