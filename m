Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSFSXzH>; Wed, 19 Jun 2002 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSFSXzG>; Wed, 19 Jun 2002 19:55:06 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:35976 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318065AbSFSXzF>; Wed, 19 Jun 2002 19:55:05 -0400
Date: Thu, 20 Jun 2002 00:54:52 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christopher Li <chrisl@gnuchina.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020620005452.M5119@redhat.com>
References: <20020619113734.D2658@redhat.com> <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <3D10E5FE.A3FA3AEF@zip.com.au> <20020619234340.A24016@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020619234340.A24016@redhat.com>; from sct@redhat.com on Wed, Jun 19, 2002 at 11:43:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 11:43:40PM +0100, Stephen C. Tweedie wrote:

> Well, it has some interesting properties, such as the hash function
> being a constant:
> 
> +	return 80; /* FIXME: for test only */
> 
> which I assume was an artifact of some testing Christopher was doing.
> :)
> 
> I'm checking out a proper hash function at the moment.

Done, checked into ext3 cvs (features-branch again.)

Deleting and recreating 100,000 files with this kernel:

[root@spock test0]# time xargs rm -f < /root/flist.100000 

real    0m14.305s
user    0m0.750s
sys     0m5.430s
[root@spock test0]# time xargs touch < /root/flist.100000 

real    0m16.244s
user    0m0.530s
sys     0m6.660s

that's an average of 160usec per create, 140usec per delete elapsed
time, and 66/54usec respectively system time.  

I assume the elapsed time is greater only because we're starting to
wrap the journal due to the large amount of metadata being touched
(we're touching a lot of inodes doing the above, which I could avoid
by making hard links instead of new files.)  Certainly, limiting the
test to 10,000 files lets it run at 100% cpu.

--Stephen
