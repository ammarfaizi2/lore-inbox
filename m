Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289398AbSAVVrl>; Tue, 22 Jan 2002 16:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289388AbSAVVra>; Tue, 22 Jan 2002 16:47:30 -0500
Received: from web21207.mail.yahoo.com ([216.136.175.165]:2180 "HELO
	web21207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289387AbSAVVrL>; Tue, 22 Jan 2002 16:47:11 -0500
Message-ID: <20020122214710.41059.qmail@web21207.mail.yahoo.com>
Date: Tue, 22 Jan 2002 13:47:10 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: tcp_recvmsg and tcp_data_wait with respect to select
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have been writing a TCP stack. In my implementation
of tcp_recvmsg, I put the calling process to sleep
around my device's waitqueue by doing a 
interruptible_sleep_on(&mywaitq);
and then wake the caller on an interrupt.

This functionality works fine for an application that
calls recv() and expects to block. However, an
application like netcat/nc calls select on an input
filehandle (stdin i think) as well as the recv() 
handle. When this is done, and I put the caller to
sleep, recv works fine but the application is no
longer
woken out of select by standard input. This would
suggest that the way I put the caller to sleep is
different than the way linux's tcp_recvmsg does it.
Looking at the code, I see tcp_data_wait which does
approximately the same thing. I instrumented this
area with some debug and noticed that when running 
netcat this is not what is called. I will continue to
look for where tcp_recvmsg actually puts the caller 
to sleep. In the mean time, I am hoping for any
hints/suggestions that could help me solve this issue.

                                   Thanks,
                                   Melkor


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
