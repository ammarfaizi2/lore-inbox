Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSDWR3o>; Tue, 23 Apr 2002 13:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSDWR3n>; Tue, 23 Apr 2002 13:29:43 -0400
Received: from [192.82.208.96] ([192.82.208.96]:8349 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315276AbSDWR2l>;
	Tue, 23 Apr 2002 13:28:41 -0400
Date: Mon, 22 Apr 2002 16:49:25 -0700
From: Jesse Barnes <jbarnes@sgi.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch to /proc/meminfo to display NUMA stats
Message-ID: <20020422234925.GA1173212@sgi.com>
In-Reply-To: <25270000.1019495119@flay> <6087.1019518771@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I implemented something kind of like this for the discontig project,
but I called it /proc/discontig.  The patch just walked all the
pgdata_t structures and did its best to find out where the memory was
being used.  See http://sourceforge.net/projects/discontig for the
patch.  The first column of the output should probably be called
'region' or something, since it's not NUMA specific at all...

Jesse

On Tue, Apr 23, 2002 at 09:39:31AM +1000, Keith Owens wrote:
> On Mon, 22 Apr 2002 10:05:19 -0700, 
> "Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
> >Below is a patch to /proc/meminfo to display free, used and total
> >memory per node on a NUMA machine. It works fine on an ia32
> >machine, but is not yet ready for submission until I make it generic.
> >Before I go to the effort of doing that, I thought I'd seek some feedback.
> >
> >diff -urN virgin-2.4.18/fs/proc/proc_misc.c linux-2.4.18-meminfo/fs/proc/proc_misc.c
> >--- virgin-2.4.18/fs/proc/proc_misc.c	Tue Nov 20 21:29:09 2001
> >+++ linux-2.4.18-meminfo/fs/proc/proc_misc.c	Mon Apr 15 09:31:32 2002
> >+#ifdef CONFIG_NUMA
> >+	for (nid = 0; nid < numnodes; ++nid) {
> >+		si_meminfo_node(&i, nid);
> >+		len += sprintf(page+len, "\n"
> >+			"Node %d MemTotal:     %8lu kB\n"
> >+			"Node %d MemFree:     %8lu kB\n"
> >+			"Node %d MemUsed:     %8lu kB\n"
> >+			"Node %d HighTotal:    %8lu kB\n"
> >+			"Node %d HighFree:     %8lu kB\n"
> >+			"Node %d LowTotal:     %8lu kB\n"
> >+			"Node %d LowFree:      %8lu kB\n",
> >+			nid, K(i.totalram),
> >+			nid, K(i.freeram),
> >+			nid, K(i.totalram-i.freeram),
> >+			nid, K(i.totalhigh),
> >+			nid, K(i.freehigh),
> >+			nid, K(i.totalram-i.totalhigh),
> >+			nid, K(i.freeram-i.freehigh));
> >+	}
> >+#endif
