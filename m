Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRGCO6K>; Tue, 3 Jul 2001 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264728AbRGCO6B>; Tue, 3 Jul 2001 10:58:01 -0400
Received: from NET.WAU.NL ([137.224.10.12]:59151 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S264759AbRGCO5w>;
	Tue, 3 Jul 2001 10:57:52 -0400
Date: Tue, 03 Jul 2001 16:57:50 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <01070311300700.00765@phoenix>; from florian@galois.de on Tue,
 Jul 03, 2001 at 11:31:42AM +0200
To: linux-kernel@vger.kernel.org
Message-id: <20010703165750.A1521@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 4:53pm  up  7:18,  2 users,  load average: 0.01, 0.03, 0.00
X-Reverse-Engineered: High priority for sending SMS messages
In-Reply-To: <3B40611D.F1485C1B@N-Club.de> <01070311300700.00765@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  0, Florian Schmitt <florian@galois.de> wrote:
> 
> > Does anybody else got these errors or knows about a solution for this ??
> 
> Same problem here, it won't run at all on newer kernels. But it isn't even 
> 100% stable in 2.2.x here - on very high network traffic the card stops 
> working. In this case, it helps to pull the network plug for a short time, 
> then everything goes back to normal. I reduced speed to 10MB, and now it is 
> stable at least in 2.2.x. 

I use (kernel 2.4.4 and 2.4.5) a cron script that pings, and will run 
ifdown eth0; ifup eth0
when the ping fails, this seems to be good enough to get it up and running
again, sometimes I need to reload the module, but it's indeed very annoying.

if ! ping -c 1 -n -q 192.168.100.2 ; then
	ifdown eth0
	ifup eth0
	if ! ping -c 1 -n -q 192.168.100.2 ; then
		ifdown eth0
		rmmod epic100
		insmod epic100
		ifup eth0
	fi
fi

regards,
	Olivier
