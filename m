Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271365AbRH1PI7>; Tue, 28 Aug 2001 11:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271349AbRH1PIt>; Tue, 28 Aug 2001 11:08:49 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:60859 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S271307AbRH1PIh>; Tue, 28 Aug 2001 11:08:37 -0400
Message-ID: <3B8BB3BA.7FBC8EE4@us.ibm.com>
Date: Tue, 28 Aug 2001 10:07:38 -0500
From: Andrew Theurer <habanero@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com.suse.lists.linux.kernel> <3B8AA7B9.8EB836FF@namesys.com.suse.lists.linux.kernel> <oupsneck77v.fsf@pigdrop.muc.suse.de> <3B8B755F.D6317A9A@crm.mot.com> <20010828125003.A27996@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Tue, Aug 28, 2001 at 12:41:35PM +0200, Emmanuel Varagnat wrote:
> >
> > Andi Kleen wrote:
> > >
> > > It does not really look like a locking problem. If you look at the profiling
> > > logs it is pretty clear that the problem is the algorithm used in
> > > bitmap.c:find_forward. find_forward and reiserfs_in_journal
> > > ...
> > > journaled blocks set also, to quickly skip them for the common case.
> >
> > I'm very interested in the way you did profiling.
> > Did you compile the kernel with profiling options (gprof ?) ?
> > If so, where the profiling information file is saved ?
> 
> I did not do any profiling in this case; I just read an existing log.
> If you want to do profiling yourself you could use the simple
> builtin statistical profiler: boot with profile=2 on the command line
> and read the log at anytime using the readprofile command.
> Other ways are documented on the lse homepage http://lse.sourceforge.net

The profiles I provided were with SGI's kernprof 0.9.2.  I chose ACG,
which does have a lot of overhead (cg_record_arc and mcount), but also
provides a lot of information.  I have a separate kernel for each
filesystem and each filesystem+profle_patch (10 kernels).  No modules
were used so that all profiles have no 'unknown kernel' functions.  Each
profile was taken for 60 seconds, starting at 90 seconds into the test. 
All profiles were taken on the 44 client test.  

Andrew Theurer
