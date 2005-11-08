Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVKHD1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVKHD1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVKHD1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:27:05 -0500
Received: from imo-m14.mx.aol.com ([64.12.138.204]:36344 "EHLO
	imo-m14.mx.aol.com") by vger.kernel.org with ESMTP id S965348AbVKHD1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:27:02 -0500
From: AndyLiebman@aol.com
Message-ID: <206.db80c15.30a174f6@aol.com>
Date: Mon, 7 Nov 2005 22:26:46 EST
Subject: Update on Timer Frequencies
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Your system looks pretty much interrupt driven, and I would assume  that
>all these are of same importance.  So I would actually  recommend the
>vanilla kernel, with HZ=100 and preemption turned  off.

Hi Steve, 

I thought I would update you (and those on the  list who care) about my real 
world experience comparing the 2.6.14 kernel  compiled with the timer 
frequency set to 100 versus 1000. 
 
If you recall, I'm running a video server that is taking in and sending out  
a large number of streams of video and audio clips that range in data rates 
from  3.8 to 28 MB/sec. 
 
We have a benchmark test that we developed that simulates multiple  
non-linear video editing workstations playing back sequences of video each from  their 
own timeline. We developed this test mostly to tune our storage subsystem,  so 
it's not a perfect test to evaluate timer frequencies (because it doesn't  
involve any network traffic). 
 
Each test is really a sequence of scripts that a) run dd on a  trio of one 
video and two audio files and b) move on to the next script  until all scripts 
have been executed, each time reading data from the RAIDS and  writing the data 
to /dev/null until 21 clips worth of data have been read. We do  this in 
parallel 5, 6, 10, 15 times to simulate that same number of workstations  calling 
for data simultaneously. 
 
The test is an approximate simulation of video  editing workstations playing 
back unique sequences of 21 clips that each  range in length from 3 to 5 
seconds and that run at a rate of 18 MB/sec video  (which is roughly 8-bit 
uncompressed standard definition). 
 
The test puts extreme stress on our RAID subsystem -- forcing drives to  seek 
all over the place to play back these random clips (think of each sequence  
as a little 90 second story with 21 separate shots). 
 
After conducting many tests over the weekend, we concluded that the tests  
consistently took 6 percent longer to complete when running under a kernel  
compiled with the 100 hz timer versus an identical kernel compiled with a 1000  hz 
timer. 
 
Again, I realize this isn't a perfect simulation of what our server does in  
real life; we weren't moving data over a network -- thus there were no  NIC 
card interrupts involved, no samba or netatalk work taking place, and  instead 
all of our scripts and dd commands are running on the server. 
 
Still, the results are interesting. That plus the fact that our "user  
management applications" open and run excruciatingly slowly when the timer  
frequency is 100 versus 1000 (3 x longer to open the application) is making us  stick 
with a timer frequency of 1000 for now. 
 
Thanks again for your help. I'm sorry if I offended anyone on this list by  
writing from an AOL address. 
