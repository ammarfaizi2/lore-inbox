Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRFRRpE>; Mon, 18 Jun 2001 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbRFRRoz>; Mon, 18 Jun 2001 13:44:55 -0400
Received: from quasar.osc.edu ([192.148.249.15]:33749 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S262116AbRFRRol>;
	Mon, 18 Jun 2001 13:44:41 -0400
Date: Mon, 18 Jun 2001 13:44:33 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: getrusage vs /proc/pid/stat?
Message-ID: <20010618134433.C9415@osc.edu>
In-Reply-To: <3B2D8ED0.40B299B5@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B2D8ED0.40B299B5@kegel.com>; from dank@kegel.com on Sun, Jun 17, 2001 at 10:17:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dank@kegel.com said:
> I'd like to monitor CPU, memory, and I/O utilization in a 
> long-running multithreaded daemon under kernels 2.2, 2.4,
> and possibly also Solaris (#ifdefs are ok).
> 
> getrusage() looked promising, and might even work for CPU utilization.
> Dunno if it returns info for all child threads yet, haven't tried it.
> In Linux, though, getrusage() doesn't return any info about RAM.
> 
> I know I can get the RSS and VSIZE under Linux by parsing /proc/pid/stat,
> but was hoping for a faster interface (although I suppose a seek,
> a read, and an ascii parse isn't *that* slow).  Is /proc/pid/stat
> the only way to go under Linux to monitor RSS?

getrusage() isn't really the system call you want for this.

There is a max RSS value, which linux could support but doesn't, but
you seem to want to see the current RSS over time.  Search the archive
for various patches/complaints about getrusage.

For vsize, most OSes offer time-integral averages of text, data, and
stack sizes via getrusage().  Again, more of an aggregate than a current
snapshot, and again, linux returns zero for these currently.

		-- Pete
