Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263393AbRFFOwk>; Wed, 6 Jun 2001 10:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFFOwa>; Wed, 6 Jun 2001 10:52:30 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:29463 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263393AbRFFOwT>;
	Wed, 6 Jun 2001 10:52:19 -0400
Message-ID: <3B1E437C.D5D339EB@illusionary.com>
Date: Wed, 06 Jun 2001 10:51:40 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com> <3B1DEAC7.43DEFA1C@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> The drive is inactive because it isn't needed, the machine is
> running loops on data in memory.  And it is unresponsive because
> nothing else is scheduled, maybe "swapoff" is easier to implement

I don't quite get what you're saying.  If the system becomes
unresponsive because  the VM swap recovery parts of the kernel are
interfering with the kernel scheduler then that's also bad because there
absolutely *are* other processes that should be getting time, like the
console windows/shells at which I'm logged in.  If they aren't getting
it specifically because the VM is preventing them from receiving
execution time, then that's another bug.

> when processes cannot try to allocate more or touch pages
> while it runs.  "swapoff" isn't something you normally do often,
> so it don't have to be nice.

I'm not familiar enough with the swapping bits of the kernel code, so I
could be totally wrong, but turning off a swap file/partition should
just call the same parts of the VM subsystem that would normally try to
recover swap space under memory pressure.  Using "swapoff" to force this
behaviour should just force it to happen manually rather than when
memory pressure is high enough.  

Which means that if that's the normal behaviour of the VM subsystem when
memory pressure gets high and it needs to recover unused pages from swap
- i.e. the machine stops running - then that's still very broken
behaviour, no matter what instigated the occurance.

> Still, I find it strange that swapoff should take much more time,
> even if you can get 2.2 to have the same amount in swap.

So do I.  Hence the original report.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#!/usr/bin/perl -w
$_='while(read+STDIN,$_,2048){$a=29;$b=73;$c=142;$t=255;@t=map
{$_%16or$t^=$c^=($m=(11,10,116,100,11,122,20,100)[$_/16%8])&110;
$t^=(72,@z=(64,72,$a^=12*($_%16-2?0:$m&17)),$b^=$_%64?12:0,@z)
[$_%8]}(16..271);if((@a=unx"C*",$_)[20]&48){$h=5;$_=unxb24,join
"",@b=map{xB8,unxb8,chr($_^$a[--$h+84])}@ARGV;s/...$/1$&/;$d=
unxV,xb25,$_;$e=256|(ord$b[4])<<9|ord$b[3];$d=$d>>8^($f=$t&($d
>>12^$d>>4^$d^$d/8))<<17,$e=$e>>8^($t&($g=($q=$e>>14&7^$e)^$q*
8^$q<<6))<<9,$_=$t[$_]^(($h>>=8)+=$f+(~$g&$t))for@a[128..$#a]}
print+x"C*",@a}';s/x/pack+/g;eval 

usage: qrpff 153 2 8 105 225 < /mnt/dvd/VOB_FILENAME \
    | extract_mpeg2 | mpeg2dec - 

http://www.eff.org/                    http://www.opendvd.org/ 
         http://www.cs.cmu.edu/~dst/DeCSS/Gallery/
