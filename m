Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSENUmx>; Tue, 14 May 2002 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316048AbSENUmx>; Tue, 14 May 2002 16:42:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9836 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316047AbSENUmw>; Tue, 14 May 2002 16:42:52 -0400
Date: Tue, 14 May 2002 16:42:45 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tony.P.Lee@nokia.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: InfiniBand BOF @ LSM - topics of interest
Message-ID: <20020514164245.C13781@devserv.devel.redhat.com>
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A206D@mvebe001.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 14 May 2002 13:19:13 -0700
> From: <Tony.P.Lee@nokia.com>

Hrm. Didn't a guy from Nokia cooked a bizzare SM or an IB switch
software, which required ultra-fast mprotect?
 
> I like to see user application such as VNC, SAMBA build directly
> on top of IB API.  I have couple of IB cards that can 
> send 10k 32KBytes message (320MB of data) every ~1 second over 
> 1x link with only <7% CPU usage (single CPU xeon 700MHz).  
> I was very impressed.  
> 
> Go thru the socket layer API would just slow thing down.
>[...]

Do you have any data to back up this claim about socket layer?

Also, time and time again I see the same bullshit (sometimes
from intelligent people!). OF COURSE, it is TRIVIAL to send
messages (or receive messages), in fact, with a correct HCA
design IB allows it to be done from user mode. It is not where
the problem is. The problem is the delivery of notifications.
A notification is an interrupt (unless your application hogs
the CPU by CQ polling), and an interrupt is a context switch.
It takes infinitely smaller amount of time to post a work
request than to retire it on Infiniband. Best people are
cracking their heads over it. Ashok Raj, THE Intel's ARCHITECT
went as far as writing to linux-kernel asking for additional
arguments to RT signals (crazy, huh? :). Oracle gave up and said that
a) they do not mind hogging CPUs, they are the only application
running on the box anyways, and b) they only request notifications
for one in N messages [Joel, I know you are listening, care
to nod or call foul here?]

I may sound like Andre Hendrik here, but please understand
that nobody gives a flying dick about "sending 10k 32KBytes
message (320MB of data) every ~1 second over > 1x link with only
<7% CPU usage at a single CPU xeon 700MHz." My stack can do it today,
in 1500 lines of C code. It is the notification that counts.
How many RPC messages per second your clustered SQL server
can receive AND PROCESS is how many transactions it can do.

-- Pete
