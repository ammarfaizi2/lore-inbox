Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSL0BnK>; Thu, 26 Dec 2002 20:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSL0BnK>; Thu, 26 Dec 2002 20:43:10 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:29137 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S264729AbSL0BnG>; Thu, 26 Dec 2002 20:43:06 -0500
Date: Fri, 27 Dec 2002 14:51:15 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: scott@thomasons.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Measuring impact on interactive tasks
Message-ID: <8410000.1040953875@localhost.localdomain>
In-Reply-To: <200212261939.09792.scott@thomasons.org>
References: <200212261939.09792.scott@thomasons.org>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That sounds pretty reasonable; it might be interesting if it also touched 
quite a bit of memory each iteration too.

Andrew

--On Thursday, December 26, 2002 19:39:09 -0600 scott thomason 
<scott@thomasons.org> wrote:

> It crossed my mind while load testing some scheduler tunable settings
> that completely subjective monitoring of X jerkiness perhaps wasn't
> the most scientific way of measuring the interactive impact of the
> tunables. I'm no Evil Scientist, but I whipped up a perl script that
> I think accomplishes something close to capturing those statistics.
> It captures 1000 samples of what should be a precise .2 second delay
> (on an idle system it is, with a tiny bit of noise).
>
> Here's the script, along with some output produced while the system
> was under considerable load (around 13). Would something like this be
> worth developing further to help rigorously measure the interactive
> impact of the tunables? Or is there a flaw in the approach? (Jokes
> about Perl are considered below the belt...)
> ---scott
>
>
># !/usr/bin/perl
>
> use strict;
> use warnings;
>
> use Time::HiRes qw/sleep time/;
>
> my %pause = ();
>
> for (my $x = 0; $x < 1000; $x++) {
>   my $start = time();
>   sleep(.2);
>   my $stop = time();
>   my $elapsed = $stop - $start;
>
>   $pause{sprintf('%01.3f', $elapsed)}++;
> }
>
> foreach (sort(keys(%pause))) {
>   print "$_:  $pause{$_}\n";
> }
>
> exit 0;
>
>
> Sample output
>
> time ./int_resp_timer.pl
> 0.192:  1
> 0.199:  1
> 0.200:  10
> 0.201:  201
> 0.202:  53
> 0.203:  25
> 0.204:  22
> 0.205:  21
> 0.206:  34
> 0.207:  29
> 0.208:  29
> 0.209:  100
> 0.210:  250
> 0.211:  120
> 0.212:  35
> 0.213:  16
> 0.214:  17
> 0.215:  14
> 0.216:  9
> 0.217:  1
> 0.218:  3
> 0.219:  3
> 0.220:  1
> 0.222:  1
> 0.233:  1
> 0.303:  1
> 0.304:  1
> 0.385:  1
>
> real    3m28.568s
> user    0m0.329s
> sys     0m1.260s
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


