Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSC0AUM>; Tue, 26 Mar 2002 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312862AbSC0AUC>; Tue, 26 Mar 2002 19:20:02 -0500
Received: from web21203.mail.yahoo.com ([216.136.130.22]:24931 "HELO
	web21203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310517AbSC0AT4>; Tue, 26 Mar 2002 19:19:56 -0500
Message-ID: <20020327001955.99099.qmail@web21203.mail.yahoo.com>
Date: Tue, 26 Mar 2002 16:19:55 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: signal_pending() and schedule()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have been writing a hw driver for SAN. In my 
implementation of tcp_sendmsg, I attempt to force
the application to sleep until the data buffer has
been dma-ed:


    if (signal_pending(current)) {
      return -ERESTARTSYS;
    }
// no signal was pending

// timeo == MAX_SCHEDULE_TIMEOUT in this case
    timeo = schedule_timeout(timeo);
// signal is always pending
    if (signal_pending(current)) {
      return -ERESTARTSYS;
    }
This works fine for some applications like netcat,etc
but fails for netscape. In debugging this, I observe
that after calling schedule_timeout(), the sigpending
bit appears to be set immediately and thus 
schedule() doesn't actually put the process to sleep.
I will continue to look for where schedule_timeout()
or schedule() could affect sigpending. In the mean 
time, I am hoping for any hints/suggestions that could
help me solve this issue of why schedule_timeout 
appears to affect sigpending. (2.4.7-10smp on x86)

                                    Thanks,
                                    Melkor



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
