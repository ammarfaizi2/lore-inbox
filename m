Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbSIYGvW>; Wed, 25 Sep 2002 02:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbSIYGvW>; Wed, 25 Sep 2002 02:51:22 -0400
Received: from ip66-105-100-132.z100-105-66.customer.algx.net ([66.105.100.132]:3006
	"HELO godzilla.whitewlf.net") by vger.kernel.org with SMTP
	id <S261924AbSIYGvT>; Wed, 25 Sep 2002 02:51:19 -0400
Date: Wed, 25 Sep 2002 02:56:18 -0400
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: linux-kernel@vger.kernel.org, Adam Bernau <adam.bernau@itacsecurity.com>,
       Adam Taylor <iris@servercity.com>
To: Simon Kirby <sim@netnation.com>
From: Adam Goldstein <Whitewlf@Whitewlf.net>
In-Reply-To: <20020925052411.GA8951@netnation.com>
Message-Id: <E46487E7-D053-11D6-BCD3-000502C90EA3@Whitewlf.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have added nodiratime, missed that one, and switched to ext2 for 
testing... ;)
It is still running high load, but seems only slightly better , but, i 
will know more later.
It is currently at 12-23 load, with 76 httpd processes running (75 
mysql)
0% idle, 89% user per cpu avg. about 8-12 httpd processes active 
simultaneously.

Using postfix on new server, not sure how to disable locking?
Same with mysql.. can locking be disabled? how? safe?

No, no slappers ;) We did get that on the old server(almost the moment 
it was around, before it was widely known), one of the reasons I 
scrapped it so fast.

All patches are applied to the new servers, even though openssl reports 
old
'c' version, it is patched (many distros have done this, I do not know 
why they simply
don't use the new 'e'+ versions.)

The site uses php heavily, everypage has php includes and mysql lookups
(multiple languages, banner rotation, article rotation, etc...)

The customer/developer is really quite good with php/html... just not 
very adept at linux..yet ;)

You can take a look at the site (ok netiquette?) http://delcampe.com 
... please excuse the
intense lag, however, a we "are experiencing technical difficulties" 
... <har har>

I will assume the combination of diratime, journaling, software raid, 
mail locking and logging are a
bad combination.... however, I have been finding many instances online 
about software
raid performing as well, or in some cases better, than hardware raid 
setups (their tests,
not mine.. I would have assumed the reverse)  but, that reiser-fs 
performs far better than ext3 under load (with notail, noatime 
enabled... tho ext3 can out do it under light load.)

Thanks for all the info... I am going to run tests on it tomorrow 
morning during 'rush hour'. (This server's users are mostly european, 
so my peak times differ from our other sites... which is good for most 
of the day...)


On Wednesday, September 25, 2002, at 01:24 AM, Simon Kirby wrote:

> On Tue, Sep 24, 2002 at 10:38:56PM -0400, Adam Goldstein wrote:
>
>> [root@nosferatu whitewlf]# vmstat -n 1
>>    procs                      memory  swap       io     system       
>> cpu
>>  r  b  w   swpd   free   buff  cache si so  bi   bo   in   cs   us sy 
>> id
>>  5  5  2  94076 1181592 61740 219676  0  0  10   16  125   111  69 12 
>> 19
>>  7  2  4  94076 1186024 61752 219664  0  0   0  948  454  1421  95  5 
>>  0
>> 10  2  2  94076 1172288 61764 219672  0  0   0 1024  468  1425  88 12 
>>  0
>>  7  2  3  94076 1175220 61772 219660  0  0   0 1236  509  1513  93  7 
>>  0
>>  5  2  2  94076 1187824 61784 219664  0  0   0  864  419  1524  87 13 
>>  0
>>  8  1  2  94076 1170140 61792 219656  0  0   0  656  362   945  88 12 
>>  0
>>  5  7  3  94076 1182448 61800 219712  0  0  36  696  580  1616  93  7 
>>  0
>>  5  4  3  94076 1186500 61808 219740  0  0  12 1252  595  1766  90 10 
>>  0
>>  8  1  3  94076 1177424 61812 219744  0  0   0 1124  497  1588  96  4 
>>  0
>>  8  3  3  94076 1167564 61824 219748  0  0   0 1136  485  1476  88 12 
>>  0
>>  5  4  2  94076 1187024 61836 219740  0  0   0 1204  473  1659  93  7 
>>  0
>> 10  6  3  94076 1180816 61840 219832  0  0  52 1124  668  3079  73 27 
>>  0
>>  6  6  2  94076 1184404 61840 219932  0  0  88 1356 1110  1886  94  6 
>>  0
>>  8  4  2  94076 1176276 61852 219948  0  0   0 1324  683  1819  89 11 
>>  0
>>  6  4  3  94076 1183948 61860 219932  0  0   0  984  441  1296  92  8 
>>  0
>> 11  1  2  94076 1177320 61872 219940  0  0   0  948  448  1351  88 12 
>>  0
>> 12  2  2  94076 1150268 61880 219952  0  0   0  952  438  1206  88 12 
>>  0
>
> (Yes, I reformatted your vmstat.)
>
> It's mostly CPU bound (see first column), but there is some disk 
> waiting
> going on too (next two).  Most of the disk activity shows writing 
> ("bo"),
> not reading ("bi").  There is some swap use, but no swap occurred 
> during
> your dump ("si", "so"), so it's probably fine.
>
> Free memory is huge, which indicates either the box hasn't been up 
> long,
> some huge process just exited and cleared a lot of memory with it, or
> your site really is small and doesn't need anywhere near that much
> memory.  Judging by the rate of disk reads ("bi"), it looks like it
> probably has more than enough memory.
>
> A lot of writeouts are happening, and they're happening all the time 
> (not
> in five second bursts which would indicate regular asynchronous write
> out).  Are applications sync()ing, fsync()ing, fdatasync()ing, or using
> O_SYNC?  Are you using a journalling FS and are doing a lot of metadata
> (directory) changes?  We saw huge problems on our mail servers when we
> switched to ext3 from ext2 when with ext2 they were almost always idle
> (load went from 0.2, 0.4 to 20, 30) because we're using dotlocking 
> which
> seems to annoy ext3.
>
> If you're using a database, try disabling fsync() mode.  Data integrity
> after crashes might be more interesting (insert fsync() flamewar here),
> but it mith help a lot.  At least try it temporarily to see if this is
> what is causing the load.
>
> Always mount your filesystems with "noatime" and "nodiratime".  I mount
> hundreds of servers this way and nobody ever notices (except that disks
> last a lot longer and there are a lot less writeouts on servers that 
> do a
> lot of reading, such as web servers).  If you don't do this, _every_ 
> file
> read will result in a scheduled writeback to disk to update the atime
> (last accessed time).  Writing atime to disk is usually a dumb idea,
> because almost nothing uses it.  I think the only program in the wild
> I've ever seen that uses the atime field is the finger daemon (wow).
>
>> CPU0 states: 87.5% user, 12.0% system,  0.0% nice,  0.0% idle
>> CPU1 states: 90.2% user,  9.4% system,  0.0% nice,  0.0% idle
>
> Looks like mostly user CPU.
>
>>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>> 16800 apache    20   0  4732 4260  2988 R    37.7  0.2   0:35 httpd
>> 21171 apache    16   0  4976 4548  3268 R    36.6  0.2   2:02 httpd
>>  6949 apache    17   0  4604 4132  2936 R    36.5  0.2   0:53 httpd
>> 29183 apache    17   0  4900 4468  3192 R    36.0  0.2   6:18 httpd
>
> First, check /tmp for .bugtraq.c, etc., and make sure this isn't the
> Slapper worm. :)
>
> Next, figure out why these processes have taken _minutes_ of CPU time 
> and
> are still running!  If these aren't the worm, you're likely using
> mod_perl or mod_php or something which can make the httpd proess take
> that much CPU.  Check which scripts and what conditions are creating
> those processes.  Play around in /proc/16800/fd, look at 
> /proc/16800/cwd,
> etc., if you can't determine what is happening by the logs.  If you're
> still stuck, try tracing them (see below).  If it's hard to catch them
> (though it appears they are slugs), switching mod_perl/mod_php to
> standalone CGIs may help.
>
> To summarize, it looks like the box is both CPU bound (above Apache
> processes) and blocking on disk writes.  The processes using the CPU 
> are
> not responsible for the writing out because they are in 'R' state
> (running); if they were writing, they would be in mostly 'D' state.
>
> If you want to see which processes are writing out, try:
>
> 	ps auxw | grep ' D '
>
> 	(Might give false positives -- just looking for 'D' state.)
>
> If you want to see whether the journalling code is doing the writing,
> try:
>
> 	ps -eo pid,stat,args,wchan | grep ' D '
>
> ...and see which functions the 'D' state processes are blocking in
> (requires your System.map file to be up-to-date).  If you see something
> about do_get_write_access (a function in fs/jbd/transaction.c), it's
> likely the ext3 journalling causing all of the writing.  This is what I
> saw in our case with the mail servers.
>
> This "ps" command is also useful for figuring out what other 
> non-running
> processes are doing, too.  However, the wchan field often shows just
> "down", which isn't very helpful.
>
> If you are getting a lot of processes sleeping in "down" and want to
> figure out where they are actually stuck, try heading over to the 
> console
> and hit right_control-scroll_lock.  Modern kernels will print a stack
> backtrace for each process, and you can manually translate the the EIP
> locations in /System.map or /boot/System.map (whatever matches your
> kernel) to the function names to find functions the kernel is/was in.
>
> To find the function in System.map, first make make sure it is sorted.
> Next, incrementally search for the first EIP, number by number.  The 
> EIP
> provided in the process list dump will always be higher than the actual
> function offset, because it will be somewhere in the middle of the
> function (System.map lists the beginning of each function).  If you 
> don't
> have incremental search, this might be tedious.  Some versions of 
> "klogd"
> will do this translation for you; you might want to check your 
> kern.log.
> You may also be able to coax "ksymoops" into doing the translation for
> you.
>
> If you cannot find a match in System.map, the EIP may be in a module
> (requires loading modules with a symbol dump to trace).  Try the next 
> EIP
> first, you can often get a good idea of what is happening by just 
> tracing
> further back.  Once you've done this a few times, you'll get used to
> seeing the module offsets being quite different from built-in offsets.
>
> If you want to figure out what a running ('R') process is doing, first
> try "strace -p <pid>".  If it's not making many or any system calls 
> (eg:
> an endless loop or very user-CPU-intensive loop), try ltrace.  If that
> provides nothing useful the only other option is to try attaching to it
> with gdb and do a backtrace:
>
> 	gdb /proc/<pid>/exe
> 	attach <pid>
> 	bt
>
> ...but you may need to compile with debugging symbols for this to 
> provide
> useful output.  Chances are you won't need to do this, and "strace"
> will give you a pretty good idea about what is happening.
>
> There should be enough information you can gather from these tools to
> figure out what is happening.  "vmstat 1" is usually the quickest way 
> to
> get a general idea of what is happening, and "ps auxwr" and "ps aux |
> grep ' D '" are useful for starting to narrow it down.
>
> Hope this helps. :)
>
> Simon-
>
> [  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
> [       sim@stormix.com       ][       sim@netnation.com        ]
> [ Opinions expressed are not necessarily those of my employers. ]
>
-- 
Adam Goldstein
White Wolf Networks

