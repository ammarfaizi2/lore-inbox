Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291522AbSBSRnS>; Tue, 19 Feb 2002 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291533AbSBSRnI>; Tue, 19 Feb 2002 12:43:08 -0500
Received: from 162-39.84.64.covalent.net ([64.84.39.162]:30414 "EHLO
	doom.sfo.covalent.net") by vger.kernel.org with ESMTP
	id <S291522AbSBSRm6>; Tue, 19 Feb 2002 12:42:58 -0500
Date: Tue, 19 Feb 2002 09:42:14 -0800
From: john <john@zlilo.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@zip.com.au>, john <john@zlilo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kupdated using all CPU
Message-ID: <20020219094214.A140@doom.sfo.covalent.net>
In-Reply-To: <20020218134041.A2586@doom.sfo.covalent.net> <3C717C72.72A994D3@zip.com.au> <3C717C72.72A994D3@zip.com.au> <20020218141920.D2586@doom.sfo.covalent.net> <3C71848A.3DA9BC42@zip.com.au> <m18z9q3wej.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m18z9q3wej.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 18, 2002 at 09:53:08PM -0700
X-Linux: http://zlilo.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Mon, Feb 18, 2002 at 09:53:08PM -0700] ebiederm@xmission.com wrote:
+ Andrew Morton <akpm@zip.com.au> writes:
+ 
+ > john wrote:
+ > > 
+ > > [Mon, Feb 18, 2002 at 02:13:06PM -0800] akpm@zip.com.au wrote:
+ > > + john wrote:
+ > > + >
+ > > + > hi,
+ > > + > ive searched all over and found many references to this problem, but
+ > > + > never found an actual solution.  the problem is that during heavy
+ > > + > disk I/O, kupdated will periodically take up ALL the cpu.
+ > > +
+ > > + I've seen a couple of reports of this, nothing to indicate that it's
+ > > + a common problem?
+ > > +
+ > > + In the other reports, it was related to extremely low disk throughput.
+ > > + What does `hdparm -t /dev/hda' say?
+ > > 
+ > > root@doom:~# hdparm -t /dev/hda
+ > > 
+ > > /dev/hda:
+ > >  Timing buffered disk reads:  64 MB in 25.60 seconds =  2.50 MB/sec
+ > 
+ > ugh.  OK, I'll see if I cen reproduce this - there's no reason
+ > why disk suckiness should cause high CPU load.  But you need to
+ > pay some attention to your IDE settings in kernel config, and
+ > possibly tuning.
+ 
+ 
+ Another possibility with the same symptoms is that there are simply
+ very large I/O request starving everything else out.  When some
+ crucial data needs to be paged back in.  john can you confirm you
+ looked in top and saw kupdate taking 100% of the cpu?

yes, i did.  another thing that makes it pretty obvious is the cpu time reported by ps.  kupdated cpu time will stay 0:00 until i run into the condition i described.  then kupdated cpu time will jump as much as 0:45.

but i have fixed the issue by using the correct ide driver.  though, someone may want to look into this anyway...dunno..
-j
