Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUFYTuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUFYTuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFYTuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:50:07 -0400
Received: from mout1.freenet.de ([194.97.50.132]:28130 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S265530AbUFYTtr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:49:47 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Willy Tarreau <willy@w.ods.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Fri, 25 Jun 2004 21:48:33 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de> <20040625190533.GI29808@alpha.home.local>
In-Reply-To: <20040625190533.GI29808@alpha.home.local>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406252148.37606.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 June 2004 21:05, you wrote:
> Hi Michael,
> 
> On Fri, Jun 25, 2004 at 08:44:22PM +0200, Michael Buesch wrote:
>  
> > I don't know what the file wchan is good for, but here is
> > it's output:
> > mb@lfs:/proc/11000> cat wchan
> > sys_wait4
> 
> I bet the process is waiting for a SIGCHLD from a previously forked
> process. Con, would it be possible that under some circumstances,
> a process does not receive a SIGCHLD anymore, eg if the child runs
> shorter than a full timeslice or something like that ? In autoconf
> scripts, there are lots of very short operations that might trigger
> such unique cases.

Hm. 11000 is a bash, so it forked some process. Just wanted to note,
that there are _no_ Zombies around, but this wait()ing bash.


load grows and grows:

top - 21:40:07 up  3:55,  7 users,  load average: 10.59, 10.25, 9.99
Tasks:  91 total,  12 running,  79 sleeping,   0 stopped,   0 zombie
Cpu(s):  13.7% user,  10.3% system,  76.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    515624k total,   466520k used,    49104k free,    43144k buffers
Swap:   976712k total,       92k used,   976620k free,   207184k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command                                                                   
 2060 mb        39  19 38872  28m 2904 R 76.0  5.7 153:16.26 FahCore_78.exe                                                            
 2270 mb        20   0 32428 7924  10m S 13.6  1.5  32:02.58 tvtime                                                                    
 2149 root      20   0  187m  41m 149m S  6.0  8.3  17:10.37 X                                                                         
 8936 mb        20   0 32736  20m  29m S  2.0  4.0   2:33.62 ksysguard                                                                 
 2238 mb        20   0 28628  15m   9m S  0.7  3.1   0:45.02 gkrellm                                                                   
 2315 mb        20   0 57052  11m  11m S  0.3  2.3   0:22.20 beep-media-play                                                           
 8937 mb        20   0  2012 1072 1592 S  0.3  0.2   0:38.52 ksysguardd                                                                
    1 root      20   0  1412  520 1252 S  0.0  0.1   0:00.30 init                                                                      
    2 root      39  19     0    0    0 R  0.0  0.0   0:00.00 ksoftirqd/0                                                               
    3 root      10 -10     0    0    0 S  0.0  0.0   0:00.16 events/0
... following more processes with 0.0% CPU.

As you can see, it's impossible to generate a load of 10.59 with these
few processes running. There are two processes running full time.
FahCore_78.exe at nice 19 and tvtime never uses more then 15% CPU.

But as the load grows, the system is usable as with load 0.0.
And it really should be usable with 76.0% nice. ;) No problem here.
This really high load is not correct.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3IGRFGK1OIvVOP4RAiemAKCnU2dTT9S3OWRRRKiFjYCfwVYk2gCeMVS6
nFs/eoY4VDwlQns4AK9te2c=
=NFUT
-----END PGP SIGNATURE-----
