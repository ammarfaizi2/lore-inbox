Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRJQEqX>; Wed, 17 Oct 2001 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJQEqN>; Wed, 17 Oct 2001 00:46:13 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:3326 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S274627AbRJQEqA>; Wed, 17 Oct 2001 00:46:00 -0400
From: rwhron@earthlink.net
Date: Wed, 17 Oct 2001 00:48:39 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011017004839.A15996@earthlink.net>
In-Reply-To: <20011016081639.A209@earthlink.net> <20011017021242.S2380@athlon.random> <20011017043103.D2380@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017043103.D2380@athlon.random>; from andrea@suse.de on Wed, Oct 17, 2001 at 04:31:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 04:31:03AM +0200, Andrea Arcangeli wrote:
> I noticed that anotehr thing that changed between vanilla 2.4.13pre2 and
> 2.4.13pre3 is the setting of page_cluster on machine with lots of ram.
> 
> You'll now find the page_cluster set to 6, that means "1 << 6 << 12"
> bytes will be paged in at each major fault, while previously only "1 <<
> 4 << 12" bytes were paged in.
> 
> So I'd suggest to try again after "echo 4 > /proc/sys/vm/page-cluster"
> to see if it makes any difference.
> 
> Andrea

You Rule!

The tweak to page-cluster is basically magic for this test.

With page-cluster=4, the mp3blaster sputtered like 2.4.13pre2aa1.
Better, but not beautiful.

Real beauty happens with page-cluster=2.  There is virtually no sputter.  
And the wall clock time is a little better than 2.4.13pre2aa1!

I don't know what page-cluster size is best for everything, but 
2.4.12aa1 (which was very good IMHO), sputtered about 10 seconds per 
iteration, and each iteration took 64 seconds.

2.4.13pre3aa1 with no sputters:  48 seconds.

Amazing!

Also, interactive "feel" is much better too.  This test would
really brutalize keyboard response.  With 2.4.13-pre3aa1 and 
page-cluster=2, the box is still usable.  (for more than listening
to mp3's  :))

page-cluster = 6

Averages for 10 mtest01 runs
bytes allocated:                    1236166246
User time (seconds):                2.299
System time (seconds):              2.951
Elapsed (wall clock) time:          41.969
Percent of CPU this job got:        12.00
Major (requiring I/O) page faults:  113.5
Minor (reclaiming a frame) faults:  302580.3

page-cluster = 4

Averages for 10 mtest01 runs
bytes allocated:                    1237529395
User time (seconds):                2.097
System time (seconds):              2.788
Elapsed (wall clock) time:          49.394
Percent of CPU this job got:        9.50
Major (requiring I/O) page faults:  120.3
Minor (reclaiming a frame) faults:  302914.1

page-cluster = 2

Averages for 10 mtest01 runs
bytes allocated:                    1239521689
User time (seconds):                2.051
System time (seconds):              2.785
Elapsed (wall clock) time:          47.878
Percent of CPU this job got:        9.80
Major (requiring I/O) page faults:  114.0
Minor (reclaiming a frame) faults:  303399.7

The wall clock time went up somewhat from page-cluster=6. 
Here is where we were before:

2.4.13-pre2aa1

Averages for 10 mtest01 runs
bytes allocated:                    1245184000
User time (seconds):                2.050
System time (seconds):              2.874
Elapsed (wall clock) time:          49.513
Percent of CPU this job got:        9.70
Major (requiring I/O) page faults:  115.6
Minor (reclaiming a frame) faults:  304781.9

2.4.12aa1

Averages for 10 mtest01 runs
bytes allocated:                    1253362892
User time (seconds):                2.099
System time (seconds):              2.823
Elapsed (wall clock) time:          64.109
Percent of CPU this job got:        7.50
Major (requiring I/O) page faults:  135.2
Minor (reclaiming a frame) faults:  306779.8


-- 
Randy Hron

