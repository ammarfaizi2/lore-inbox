Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272385AbRH3SKU>; Thu, 30 Aug 2001 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272387AbRH3SKL>; Thu, 30 Aug 2001 14:10:11 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:43533 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S272385AbRH3SKI>;
	Thu, 30 Aug 2001 14:10:08 -0400
Date: Thu, 30 Aug 2001 12:10:25 -0600
From: Val Henson <val@nmt.edu>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Lost TCP retransmission timer (was Re: tcp connection hangs on connect)
Message-ID: <20010830121025.A15880@boardwalk>
In-Reply-To: <20010829195259.B11544@boardwalk> <200108301621.UAA05134@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108301621.UAA05134@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Aug 30, 2001 at 08:21:16PM +0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 08:21:16PM +0400, kuznet@ms2.inr.ac.ru wrote:
> 
> Your hopes were groundless.
> Actually, you could change subject, this apparently has nothing
> to do with your problem and this is misleading.

You're right.  I thought the subject was "tcp connection hangs." :)

> I have no idea what happens in your case, apparently, retransmission
> timer is lost on sender, which is absolutely impossible. :-)
> Well, send me cat of /proc/tcp after the stall happened.

At least one of the tcpdumps I took showed at least one successful
retransmission before the failure.  Here's /proc/tcp at 1 second
intervals, starting just before the connection starts and ending after
I kill it.  It looks to me like the timer is going off but the segment
isn't getting transmitted.

  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 00000000:00000000 02:000AFC42 00000000     0        0 1502 3 c05c0040 21 4 5 2 -1                               
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 00000000:00000000 02:000AFBDD 00000000     0        0 1502 2 c05c0040 21 4 5 2 -1                               
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 00003890:00000000 01:00000011 00000000     0        0 1502 9 c05c0040 21 4 1 2 2                                
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:00000007 00000001     0        0 1502 15 c05c0040 46 4 1 1 2                               
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:000000B5 00000003     0        0 1502 15 c05c0040 184 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:0000004F 00000003     0        0 1502 15 c05c0040 184 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:00000159 00000004     0        0 1502 15 c05c0040 368 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:000000F3 00000004     0        0 1502 15 c05c0040 368 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:0000008D 00000004     0        0 1502 15 c05c0040 368 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:00000027 00000004     0        0 1502 15 c05c0040 368 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:000002A1 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:0000023B 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:000001D5 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:0000016F 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:00000109 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:000000A3 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 773 1 c05c0360 300 0 0 2 -1                               
   1: C6116429:0016 C611642A:046B 01 000032E8:00000000 01:0000003D 00000005     0        0 1502 15 c05c0040 736 4 1 1 2                              
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 7
