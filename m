Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281069AbRKDSex>; Sun, 4 Nov 2001 13:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281105AbRKDSds>; Sun, 4 Nov 2001 13:33:48 -0500
Received: from lilly.ping.de ([62.72.90.2]:61197 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S281086AbRKDScm>;
	Sun, 4 Nov 2001 13:32:42 -0500
Date: 4 Nov 2001 19:27:25 +0100
Message-ID: <20011104192725.A847@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <Pine.LNX.4.33.0111031740330.9962-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0111031740330.9962-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 03, 2001 at 05:44:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 05:44:18PM -0800, Linus Torvalds wrote:
> 
> Ok, this is hopefully the last 2.4.14 pre-kernel, and per popular demand I
> hope to avoid any major changes between "last pre" and final. So give it a
> whirl, and don't whine if the final doesn't act in a way you like it to.
> 
> Special thanks to Andrea - we spent too much time tracking down a subtle
> sigsegv problem, but we got it in the end.
> 
> Also, I was able to reproduce the total lack of interactivity that the
> google people complained about, and while I didn't run the google tests
> themselves, at least the load I had is fixed.
> 
> But most of the changes are actually trying to catch up with some of the
> emails that I ignored while working on the VM issues. I hope the VM is
> good to go, along with a real 2.4.14.

The results for 2.4.14-pre8 of my kernel compile tests are following:

                    j25       j50       j75      j100                                     
                                                                                          
2.4.13-pre5aa1:   5:02.63   5:09.18   5:26.27   5:34.36                                   
2.4.13-pre5aa1:   4:58.80   5:12.30   5:26.23   5:32.14                                   
2.4.13-pre5aa1:   4:57.66   5:11.29   5:45.90   6:03.53                                   
2.4.13-pre5aa1:   4:58.39   5:13.10   5:29.32   5:44.49                                   
2.4.13-pre5aa1:   4:57.93   5:09.76   5:24.76   5:26.79                                   
                                                                                          
2.4.14-pre6:      4:58.88   5:16.68   5:45.93   7:16.56                                   
2.4.14-pre6:      4:55.72   5:34.65   5:57.94   6:50.58                                   
2.4.14-pre6:      4:59.46   5:16.88   6:25.83   6:51.43                                   
2.4.14-pre6:      4:56.38   5:18.88   6:15.97   6:31.72                                   
2.4.14-pre6:      4:55.79   5:17.47   6:00.23   6:44.85                                   
                                                                                          
2.4.14-pre7:      4:56.39   5:22.84   6:09.05   9:56.59                                   
2.4.14-pre7:      4:56.55   5:25.15   7:01.37   7:03.74                                   
2.4.14-pre7:      4:59.44   5:15.10   6:06.78   12:51.39*                                 
2.4.14-pre7:      4:58.07   5:30.55   6:15.37      *                                      
2.4.14-pre7:      4:58.17   5:26.80   6:41.44      *

2.4.14-pre8:      4:57.14   5:10.72   5:54.42   6:37.39
2.4.14-pre8:      4:59.57   5:11.63   6:34.97   11:23.77
2.4.14-pre8:      4:58.18   5:16.67   6:07.88   6:32.38
2.4.14-pre8:      4:56.23   5:16.57   6:15.01   7:02.45
2.4.14-pre8:      4:58.53   5:19.98   5:39.09   12:08.69

Is there anything else I can measure during the kernel compiles?
Are the numbers for >= -pre6 slower because of measures taken to
increase the "interactivity" / responsivness of the kernel?

The part that looks most suspicious to me is that the results
for make -j100 vary so much ...


Regards,

   Jogi


These are the additional infos from time -v for make -j100:

User time (seconds): 261.63
System time (seconds): 25.89
Percent of CPU this job got: 72%
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:37.39
Major (requiring I/O) page faults: 937515
Minor (reclaiming a frame) page faults: 1059195

User time (seconds): 264.69
System time (seconds): 28.47
Percent of CPU this job got: 42%
Elapsed (wall clock) time (h:mm:ss or m:ss): 11:23.77
Major (requiring I/O) page faults: 999211
Minor (reclaiming a frame) page faults: 1101511

User time (seconds): 262.22
System time (seconds): 25.11
Percent of CPU this job got: 73%
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:32.38
Major (requiring I/O) page faults: 935552
Minor (reclaiming a frame) page faults: 1064976

User time (seconds): 262.22
System time (seconds): 26.77
Percent of CPU this job got: 68%
Elapsed (wall clock) time (h:mm:ss or m:ss): 7:02.45
Major (requiring I/O) page faults: 960273
Minor (reclaiming a frame) page faults: 1075637

User time (seconds): 263.20
System time (seconds): 35.87
Percent of CPU this job got: 41%
Elapsed (wall clock) time (h:mm:ss or m:ss): 12:08.69
Major (requiring I/O) page faults: 953770
Minor (reclaiming a frame) page faults: 1105582


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
