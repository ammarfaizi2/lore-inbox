Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTH2T5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTH2T5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:57:32 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:53457 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261741AbTH2TzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:55:18 -0400
Message-ID: <3F4FAFA2.4080202@wmich.edu>
Date: Fri, 29 Aug 2003 15:55:14 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu> <m3ad9snxo6.fsf@bzzz.home.net>
In-Reply-To: <m3ad9snxo6.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it appears that you need about 10+ blocks per extent to see any 
noticable performance gain.  The problem is most files are not large 
enough to achieve this.  Most range from a few kB to a couple mB. High 
activity directories like /tmp and /usr deal mostly with numerous small 
files.  Now the reason i bring this up is that extents basically make 
your fs incompatible with any kernel not compiled with the patch, which 
means if something bad happened and you needed to use a bootable cdrom 
with some safety kernel, it wouldn't be that useful.  for such small 
improvements, it doesn't seem worth the risk to make / or directories 
like /tmp,/var,/usr,/boot,/lib etc, with extents.  The files just dont 
get large enough to make performance gains worth more than backward 
compatibility.

Now for media, like music and movies and such, this makes a lot of 
sense. Files get large enough so that the block to extent use is very 
high and the files aren't necessary to use the system.  extents are 5 
seconds faster when md5summing a 622MB file than the same file written 
without extents enabled.


I would not recommend using the patch for system directories only 
because it leaves you with no way to rescue the system and does very 
little in the way of performance for those directories. Ext3 is 
backwards compatible with ext2, this patch seemingly breaks that. 
Because of that it doesn't seem to be ext3 anymore, rather a one way 
compatibility with ext3 with a purely large media bias.



Alex Tomas wrote:
>>>>>>Ed Sweetman (ES) writes:
> 
> 
>  ES> Throughput 221.812 MB/sec 16 procs    ext2
>  ES> Throughput 159.495 MB/sec 16 procs    ext3-extents (definitely enabled)
>  ES> Throughput 147.598 MB/sec 16 procs    ext3 (patched but disabled)
> 
>  ES> There is an obvious improvement, but nothing near the 70+% increase
>  ES> you saw.  Subsequent runs run anything from a little lower than above
>  ES> for extents to 167MB/s.
> 
> it seems one of my scsi drive is a bit broken (caching, at least).
> sorry for invalid numbers. on another drive I see following:
> 
> w/o extents:
> [root@zefir root]# /root/db2.sh 2 16
> Throughput 119.199 MB/sec 16 procs
> Throughput 106.09 MB/sec 16 procs
> Average: 112.64450
> 
> 
> with extents:
> [root@zefir root]# /root/db2.sh 2 16
> Throughput 156.846 MB/sec 16 procs
> Throughput 170.591 MB/sec 16 procs
> Average: 163.71850
> 
> so, this time improvement is about 45%

