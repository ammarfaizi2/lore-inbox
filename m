Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261870AbSIYBHX>; Tue, 24 Sep 2002 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSIYBHX>; Tue, 24 Sep 2002 21:07:23 -0400
Received: from ip66-105-100-132.z100-105-66.customer.algx.net ([66.105.100.132]:53172
	"HELO godzilla.whitewlf.net") by vger.kernel.org with SMTP
	id <S261870AbSIYBHV>; Tue, 24 Sep 2002 21:07:21 -0400
Date: Tue, 24 Sep 2002 21:12:31 -0400
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Content-Type: text/plain; delsp=yes; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: linux-kernel@vger.kernel.org
To: FD Cami <stilgar2k@wanadoo.fr>
From: Adam Goldstein <Whitewlf@Whitewlf.net>
In-Reply-To: <3D90FD7B.9080209@wanadoo.fr>
Message-Id: <DDE17296-D023-11D6-AD2E-000502C90EA3@Whitewlf.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't run memtest, but, the same segfaults occurred on the old  
server, the middle server and the new server (granted the new and old  
are almost the same and used most of the same memory)

Being ECC it should report errors, as well as fix them. Using a  
different file system is on the top of our test list... reiser notail,  
noatime in particular. Never really thought about xfs.

While I agree that the segfaults are very odd, I can't find a reason  
for them.... I will run memtest    
(ftp://rpmfind.net/linux/Mandrake-devel/cooker/i586/Mandrake/RPMS/ 
memtest86-3.0-2mdk.i586.rpm  it adds a lilo boot option .. how neat! )

Some interesting tests I found regarding ext2, ext3 and reiser.
http://www.net.oregonstate.edu/~kveton/fs/


On Tuesday, September 24, 2002, at 08:04 PM, FD Cami wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Adam Goldstein wrote:
> | I have been trying to find an answer to this for the past couple  
> weeks,
> | but I have finally
> | broken down and must post this to this list. ;)
> |
> | I am running a high user load site (>20million hits/month stamp  
> auction
> | site) which runs entirely on apache/php with mysql. It was running
> | smoothly (for the most part) on as a virtual server on a relatively  
> nice
> | box(see Moya below), but started needing more and more disk space  
> (from
> | uploads, logs, etc) and kept running out of space on the root  
> partition
> | (including /var...which has mysql & weblogs)
> |
> | I decided to build a new box for it, which we were shipping to a
> | highspeed colo facility.
> |
> | While this unit was slightly less powerful, it was a clean install  
> with
> | a larger root partition (See Anubis below).  This unit started acting
> | pathetic, and had less other loads on it (old box also has lots of  
> samba
> | sharing and other low-traffic websites). The system load kept at high
> | rates constantly, 5-8 during non-peak hours , average of 10-20 during
> | most times, and spikes >100... needless to say, any load  over 5-10  
> made
> | the unit a pile of dung.
> |
> | My partner is running a similar site, under debian, on similar  
> hardware
> | (almost identical, actually) and is having -very- similar problems.
> |
> | I stripped the old server, packed it into a new 4U case (-packed!-)  
> and
> | moved just the one site (29G including pictures and sql data) to it,  
> and
> | the results are no better. This unit has even more ram, and, more  
> hard
> | drive space. (See Nosferatu below)
> |
> | We are at the end of our ropes, and are clearing our chalkboards to
> | start testing pieces of our systems... problem is, testing these  
> system
> | is difficult due to needing to put live loads on them. We need to  
> narrow
> | down the search, and need your help... please...
> |
> | We also see high amounts of apache children segfaulting under  
> load... as
> | high as 2-10/minute at times. I have tried turning off atimes, and
> | reducing tcp timeouts, etc. The big users of CPU are typically apache
> | and mysql. About 110+ instances of apache and mysqld each run in top  
> at
> | high load. CPU use bounces wildly, with most in user space.
>
> A few hints (and i'm heading to bed) :
> try running 2.4.19 + O(1) scheduler from Ingo Molnar instead of the
> stock scheduler, it improves efficiency, especially if you're SMP  
> (which
> is the case) - i've been running that on several production, medium  
> load
> machines :
> http://people.redhat.com/~mingo/O(1)-scheduler/
> NB : patch is for 2.4.19rc but applies cleanly to 2.4.19 and runs
> perfectly.
>
> Also offloading Apache with the TUX kernel-space webserver available
> from
> http://people.redhat.com/~mingo/TUX-patches/
> (yeah, same guy) could help _alot_
>
> A simple remark from a squid user : try using squid as a server-side
> proxy, also called httpd-accelerator :
> http://www.squid-cache.org/
> http://squid.visolve.com/squid24s1/httpd_accelerator.htm
> Well worth a try.
>
> I have _yet_ to do a TUX+SQUID+APACHE config, if only i had time
> to spare...
>
> Also, using a different filesystem may help.
> Maybe trying ReiserFS with the noatime AND notail options could be
> very handy. Maybe tuning XFS would do the trick.
> What are you running on now ?
>
> Also, be sure to test your machines' RAM using  
> http://www.memtest86.com/
> you shouldn't see processes segfaulting like that... It's weird.
>
> - --
>
> F. CAMI
> - ----------------------------------------------------------
> ~ "To disable the Internet to save EMI and Disney is the
> moral equivalent of burning down the library of Alexandria
> to ensure the livelihood of monastic scribes."
> ~              - John Ippolito (Guggenheim)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQE9kP17uBGY13rZQM8RAt1RAJ9wbvKi7kkhwYUqgd7zmzi4+OmPMgCbBOjL
> v2Upj2t4LL3hhRkmfO7du/8=
> =+0BK
> -----END PGP SIGNATURE-----
>
-- 
Adam Goldstein
White Wolf Networks

