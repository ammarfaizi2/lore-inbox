Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264109AbRFFT2p>; Wed, 6 Jun 2001 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFFT2f>; Wed, 6 Jun 2001 15:28:35 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:16414 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S264109AbRFFT2Z>;
	Wed, 6 Jun 2001 15:28:25 -0400
Message-ID: <3B1E8442.728C5154@illusionary.com>
Date: Wed, 06 Jun 2001 15:28:02 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
		<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
		<m1wv6p5uqp.fsf@frodo.biederman.org>
		<3B1E7ABA.EECCBFE0@illusionary.com> <m1ofs15tm0.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Derek Glidden <dglidden@illusionary.com> writes:
> 
> > The problem I reported is not that 2.4 uses huge amounts of swap but
> > that trying to recover that swap off of disk under 2.4 can leave the
> > machine in an entirely unresponsive state, while 2.2 handles identical
> > situations gracefully.
> >
> 
> The interesting thing from other reports is that it appears to be kswapd
> using up CPU resources.  Not the swapout code at all.  So it appears
> to be a fundamental VM issue.  And calling swapoff is just a good way
> to trigger it.
> 
> If you could confirm this by calling swapoff sometime other than at
> reboot time.  That might help.  Say by running top on the console.

That's exactly what my original test was doing.  I think it was Jeffrey
Baker complaining about "swapoff" at reboot.  See my original post that
started this thread and follow the "five easy steps."  :)  I'm sucking
down a lot of swap, although not all that's available which is something
I am specifically trying to avoid - I wanted to stress the VM/swap
recovery procedure, not "out of RAM and swap" memory pressure - and then
running 'swapoff' from an xterm or a console.

The problem with being able to see what's eating up CPU resources is
that the whole machine stops responding for me to tell.  consoles stop
updating, the X display freezes, keyboard input is locked out, etc.  As
far as anyone can tell, for several minutes, the whole machine is locked
up. (except, strangely enough, the machine will still respond to ping) 
I've tried running 'top' to see what task is taking up all the CPU time,
but the system hangs before it shows anything meaningful.  I have been
able to tell that it hits 100% "system" utilization very quickly though.

I did notice that the first thing sys_swapoff() does is call
lock_kernel() ... so if sys_swapoff() takes a long time, I imagine
things will get very unresponsive quickly.  (But I'm not intimately
familiar with the various kernel locks, so I don't know what
granularity/atomicity/whatever lock_kernel() enforces.)

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
