Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285415AbRLGFkf>; Fri, 7 Dec 2001 00:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285416AbRLGFk0>; Fri, 7 Dec 2001 00:40:26 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29078 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S285415AbRLGFkR>; Fri, 7 Dec 2001 00:40:17 -0500
Date: Thu, 6 Dec 2001 22:45:04 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
        rusty@rustcorp.com.au, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik vav Riel <riel@conectiva.com.br>, lars.spam@nocrew.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        lkml <linux-kernel@vger.kernel.org>, jmerkey@timpanogas.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206224504.A26478@vger.timpanogas.org>
In-Reply-To: <20011206195650.A25735@vger.timpanogas.org> <Pine.LNX.4.40.0112062021260.3900-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112062021260.3900-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Thu, Dec 06, 2001 at 08:23:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 08:23:36PM -0800, David Lang wrote:
> On Thu, 6 Dec 2001, Jeff V. Merkey wrote:
> 
> > On Thu, Dec 06, 2001 at 03:16:13PM -0800, David Lang wrote:
> > > also some applications (i.e. databases) are such that nobody has really
> > > been able to rewrite them into the shared nothing model (although oracle
> > > has attempted it, from what I hear it has problems)
> > >
> > > David Lang
> >
> > OPS (Oracle Parallel Server) is shared nothing.
> >
> 
> correct, and from what I have been hearing from my local database folks
> it's significantly less efficiant then a large SMP machine (up intil you
> hit the point where you just can't buy a machine big enough :-)
> 
> I'm interested in hearing more if you have had better experiances with it.
> 
> David Lang

I worked with the OPS code years back.  It came from DEC originally 
and is a very old technology.  It grew out of disk pinging, where 
the messages would be pinged across a shared disk.  Some cool features,
but I never saw it scale well beyond 16 nodes.  SQL queries are a lot 
like HTML requests, so similair approaches work well with them.  The code
was not so good, or readable.

Databases are "structured data" applications and present unique problems,
but most data stored on planet earth is "unstructured data", word files, 
emails, spreadsheets, etc.  The problem of scaling involves different 
approaches for these two categories, and the unstructured data problem 
is easily solvable and scalable.  

I ported Oracle to NetWare SMP in 1995 with Van Okamura (a very fun 
project), and SMP scaling was much better.  In those days, shared 
SCSI was what was around.  Writing an SOSD layer for Oracle 
was a lot of fun.  Working on OPS was also fun, but the code 
was not in such good shape.  Their method of dealing with 
deadlocks was not to.  Their approach assumed deadlocks were 
infrequent events (which they were) and they used a mathod that would 
detect them after the fact rather than before and deal with them 
then.  

I saw some impressive numbers for TPC-C come out of OPS 4 way clusters,
but more nodes than this (except the N-cube implementation) seemed to 
not do so well.

Jeff 

