Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbREEGVZ>; Sat, 5 May 2001 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbREEGVP>; Sat, 5 May 2001 02:21:15 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:37200 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131317AbREEGU6>; Sat, 5 May 2001 02:20:58 -0400
Date: Sat, 5 May 2001 02:20:55 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Seth Goldberg <bergsoft@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
In-Reply-To: <3AF389BD.81F9B398@home.com>
Message-ID: <Pine.LNX.4.10.10105050155020.15185-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2001, Seth Goldberg wrote:

> Hi,
> 
>   Before I go any further with this investigation, I'd like to get an
> idea
> of how much of a performance improvement the K7 fast_page_copy will give
> me.
> Can someone suggest the best benchmark to test the speed of this
> routine?

Arjan van de Ven did the code, and he wrote a little test harness.
I've hacked it a bit (http://brain.mcmaster.ca/~hahn/athlon.c);
on my duron/600, kt133, pc133 cas2, it looks like this:

clear_page by 'normal_clear_page'        took 7221 cycles (324.6 MB/s)
clear_page by 'slow_zero_page'           took 7232 cycles (324.1 MB/s)
clear_page by 'fast_clear_page'          took 6110 cycles (383.6 MB/s)
clear_page by 'faster_clear_page'        took 2574 cycles (910.6 MB/s)

copy_page by 'normal_copy_page'  took 7224 cycles (324.4 MB/s)
copy_page by 'slow_copy_page'    took 7223 cycles (324.5 MB/s)
copy_page by 'fast_copy_page'    took 4662 cycles (502.7 MB/s)
copy_page by 'faster_copy'       took 2746 cycles (853.5 MB/s)
copy_page by 'even_faster'       took 2802 cycles (836.5 MB/s)

70% faster!

