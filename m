Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTJUVIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTJUVIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:08:19 -0400
Received: from cibs9.sns.it ([192.167.206.29]:32269 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263310AbTJUVIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:08:13 -0400
Date: Tue, 21 Oct 2003 23:07:34 +0200 (CEST)
From: venom@sns.it
To: rwhron@earthlink.net
cc: piggin@cyberone.com.au, <linux-kernel@vger.kernel.org>, <dmo@osdl.org>,
       <akpm@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
In-Reply-To: <20031021130501.GA4409@rushmore>
Message-ID: <Pine.LNX.4.43.0310212306460.4396-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sql bench on mysql, una master, three slave, with old as-iosched.c
runs mutch better, thanx.


On Tue, 21 Oct 2003 rwhron@earthlink.net wrote:

> Date: Tue, 21 Oct 2003 09:05:01 -0400
> From: rwhron@earthlink.net
> To: piggin@cyberone.com.au, venom@sns.it
> Cc: linux-kernel@vger.kernel.org, dmo@osdl.org, akpm@osdl.org
> Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
>
> > If you have time, would you please try testing as-iosched.c from
> > test5 in a later kernel (it won't go into test8-mm1 though).
>
> copying drivers/block/as-iosched.c from 2.6.0-test5 to test8
> looks like it fixes the regression.  Here are the results so far.
>
> In the AIM7 database benchmark, jobs/minute using test5 as-iosched.c
> doubled.  At 32 tasks, jobs/min went from 300 to 601.
> At 256 tasks, jobs/min went from 552 to 1010.
>
> test5 as-iosched.c:
> cat suite7-dbase-2.6.0-test8-as
> Benchmark       Version Machine Run Date
> AIM Multiuser Benchmark - Suite VII     "1.1"   dev4-003
>
> Tasks   Jobs/Min        Real    CPU
> 32      601.0           316.3   134.0
> 64      782.6           485.8   259.2
> 96      869.1           656.1   387.6
> 128     919.3           827.0   522.8
> 160     955.0           995.2   650.3
> 192     981.9           1161.5  790.9
> 224     1002.3          1327.5  910.2
> 256     1009.9          1505.7  1027.7
>
> Unmodififed test8.
> cat suite7-dbase-2.6.0-test8
> Benchmark       Version Machine Run Date
> AIM Multiuser Benchmark - Suite VII     "1.1"   dev4-003
>
> Tasks   Jobs/Min        Real    CPU
> 32      299.8           634.0   128.6
> 64      450.5           843.9   246.5
> 96      549.7           1037.4  366.0
> 128     558.7           1360.8  497.6
> 160     522.1           1820.2  612.2
> 192     515.5           2212.4  742.7
> 224     529.9           2510.8  859.5
> 256     552.4           2753.0  980.4
>
> The AIM7 fileserver benchmark is back up to previous
> levels when test8 uses the test5 as-iosched.c:
>
>
> test5 as-iosched.c with test8.
> cat suite7-fserver-2.6.0-test8-as
> Benchmark       Version Machine Run Date
> AIM Multiuser Benchmark - Suite VII     "1.1"   dev4-003
>
> Tasks   Jobs/Min        Real    CPU
> 4       80.5            301.0   37.0
> 8       133.0           364.6   64.0
> 12      166.7           436.3   93.4
> 16      175.9           551.2   111.5
> 20      186.3           650.7   133.8
> 24      202.8           717.3   161.2
> 28      207.1           819.3   200.0
> 32      210.6           920.7   226.5
>
>
> Unmodified test8.
> cat suite7-fserver-2.6.0-test8
> Benchmark       Version Machine Run Date
> AIM Multiuser Benchmark - Suite VII     "1.1"   dev4-003
>
> Tasks   Jobs/Min        Real    CPU
> 4       42.3            573.6   40.9
> 8       63.3            765.7   71.6
> 12      83.2            874.2   95.0
> 16      87.5            1108.4  102.5
> 20      105.0           1154.6  136.7
> 24      111.2           1308.1  162.2
> 28      130.7           1297.9  185.8
> 32      134.2           1444.5  212.9
>
>
> My tiobench test hasn't completed yet, but test8 with test5's
> as-iosched.c is making good progress.  I think Nick nailed the
> changeset.
>
> --
> Randy Hron
> http://home.earthlink.net/~rwhron/kernel/bigbox.html
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

