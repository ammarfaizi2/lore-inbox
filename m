Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUFISWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUFISWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUFISVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:21:35 -0400
Received: from system65-210-78-197.hpti.com ([65.210.78.197]:21435 "EHLO
	hptimail01.HPTI.COM") by vger.kernel.org with ESMTP id S265928AbUFISVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:21:30 -0400
Subject: Re: XFS over NFS corruption
From: Craig Tierney <ctierney@hpti.com>
To: Marat Mukhitov <marat@GSTJ2W.stavanger.eur.slb.com>
Cc: Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <200406091949.47774.marat@GSTJ2W>
References: <20040609165442.GA9569@thumper2>
	 <200406091949.47774.marat@GSTJ2W>
Content-Type: text/plain
Message-Id: <1086805203.3283.0.camel@hpti9.fsl.noaa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Jun 2004 12:20:04 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2004 18:21:30.0247 (UTC) FILETIME=[95E56170:01C44E4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 11:49, Marat Mukhitov wrote:
> Andy ,
> 
> We had a similar problem. 
> Changing "async" to "sync" option of exportfs  on NFS server  helps in our case.
> 
> Regards,
> Marat 

Changing that option kills performance though.  Also, in my
case where I am getting corruption, switching to sync did
not help.

Craig

> 
> 
> On Wednesday 09 June 2004 18:54, Andy wrote:
> > I thought I had seen the bug even writing to an non-XFS nfs server, but I
> > can't absolutely confirm this at the time (I was not doing the testing at
> > the time, and some of the result may not have been accurate)
> >
> > But, the description of bug #198 on the XFS bugzilla, does sound like what
> > I am seeing.
> >
> > What I do in my tests is take a file of offsets (every group of 4 bytes
> > contains the offset of the 1st byte of the group) and copy that file to an
> > nfs mounted volume and then compare the local copy to the remote copy
> > (copying to several systems, each server is also receiving from several
> > systems).  After a while I will see errors in the compare, data appearing
> > at the wrong offset in the file.  The amount of data is small (<64k),
> > always an 8k boundary at a large offset discrepancy (100's of megs).  I've
> > attached the mkoffsetfile.c and cmpoffsets.c programs used for testing.
> >
> > Sample of cmpoffsets output :
> >
> > 431128576-431161343 (32768) (held data from 738426880-738459647)
> >  starts at a 65536-byte block
> >  ends at a 524288-byte block
> >
> > Hope this helps.
> >
> > Andy
> 
> 

