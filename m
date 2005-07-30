Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVG3A6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVG3A6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVG3AzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:55:11 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:38593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262870AbVG3Ax5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:53:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A3cPMMj7hfqIiFrQs+zAk/tEOgIYk7UVsXMSzkGR20dew0v5Qvbs+q55oLX//Od24ZsoSCT09Elr5el5kMWEBU4s1ruPvTQ22qzBNVITleuwQH24zSkjbfldFaUkEP57uoko5yau1OvWJqXuKG0HYm5VfsLgExizSOv9R2oqePs=
Message-ID: <feed8cdd0507291753777bb107@mail.gmail.com>
Date: Fri, 29 Jul 2005 17:53:54 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: Stephen Pollei <stephen.pollei@gmail.com>
To: Vitor Curado <curado.vitor@gmail.com>
Subject: Re: QoS scheduler
Cc: Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
In-Reply-To: <a5a7ef330507290724339135d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a5a7ef3305072804283f196f79@mail.gmail.com>
	 <42E94F24.6030002@felter.org>
	 <a5a7ef330507290724339135d2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/05, Vitor Curado <curado.vitor@gmail.com> wrote:
> You assumed right, Stephen: I'm interested in QoS process scheduling,
> sorry for not specifying it...
> 
> I'm taking a deeper look at the qlinux, ckrm and the plugsched
> schedulers, if you have any more links, please send them to me...
Also you didn't specify what kind of clustering you are doing and for
what ultimate purpose.

http://www.beowulf.org/
http://www-unix.mcs.anl.gov/mpi/implementations.html
http://www.csm.ornl.gov/pvm/pvm_home.html
http://www.open-mpi.org/

http://openmosix.sourceforge.net/
http://www.mosix.org/

http://www.remote-dba.cc/teas_aegis_rac06.htm
http://www.dba-oracle.com/bp/bp_book1_rac.htm
Oracle DB Real Application Clusters (RAC)
transparent application failover (TAF)

http://pgcluster.projects.postgresql.org/feature.html
http://dev.mysql.com/doc/mysql/en/replication.html

High Availability (HA)
High Performance Computing (HPC)

That can strongly effect what solutions you would want to look at.
For instance if you were running a render farm, or a scientific
compute beowulf cluster, then
your "scheduling" will be handled more in the MPI or PVM code perhaps.
The running processes themselves would most likely be using something
like SCHED_BATCH, with larger than usual time-slices. Maybe you
monitor how many mips actually get consumed and then adjust which
nodes get scheduled with what, or how many work units get handed out
to get back to fairness.
 
clock_t times(struct tms *buf);
int getrusage(int who, struct rusage *usage);
to track system and user time is about on track, but I think someone
might be able to fool you, if thats all you could use to account for
cpu time taken from another userland process.

So maybe you just need better reporting/accounting hooks and then you
can do the rest in userland?

> On 7/28/05, Wes Felter <wesley@felter.org> wrote:
> > Vitor Curado wrote:
> > > I'm working on a research about QoS schedulers for Linux clusters.
> > > Moreover, the ideal would be that the scheduler is implemented
> > > altering the native kernel scheduler. I'm kind of having trouble to
> > > find such schedulers, can anybody help me out?
> >
> > http://lass.cs.umass.edu/software/qlinux/
> > http://ckrm.sourceforge.net/

That qlinux one is new to me. I notice that the 2.6 kernel has support
for modular plugable disk I/O and network schedulers now.
So  a Hierarchical Start Time Fair Queuing (H-SFQ) network packet
scheduler module could be made.

I wonder how that Cello scheduler would stack-up to AS, Deadline, cfq,
noop, etc etc.

The qlinux cpu scheduler would be best to use plugsched for use with 2.6.x

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
