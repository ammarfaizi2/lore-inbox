Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbRBWN0c>; Fri, 23 Feb 2001 08:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRBWN0W>; Fri, 23 Feb 2001 08:26:22 -0500
Received: from 3dyn218.com21.casema.net ([212.64.94.218]:55055 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129544AbRBWN0G>;
	Fri, 23 Feb 2001 08:26:06 -0500
Date: Fri, 23 Feb 2001 15:18:08 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Message-ID: <20010223151808.A22022@home.ds9a.nl>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0EF4@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <27525795B28BD311B28D00500481B7601F0EF4@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Fri, Feb 23, 2001 at 02:20:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 02:20:27PM +0100, Heusden, Folkert van wrote:

> > With truly random PIDs, there is a much larger chance of a new process 
> > sitting on a recently used PID. 
> 
> My code runs trough the whole task_list to see if a chosen pid is already
> in use or not.

But it doesn't check for a recently used PID. Lets say your system is
exhausting 1000 PIDs/second, and that there is a window of 20ms between you
determining which PID to send to, and the recipient process receiving it.

With truely random PIDs, there is now a chance of 1-(1-1/32000)^20 that a
new process will have the PID of the process you intended your signal for.
That's 0.06%, but historically, we care for those kind of chances.

The complete formula is: 1-(1-1/32000)^(dt*pps), where dt stands for the
time interval and pps for the number of pids created per second.

Currently, there are problems if your dt*pps product is bigger than 32000,
which in practice won't ever happen.

Regards,

bert hubert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
