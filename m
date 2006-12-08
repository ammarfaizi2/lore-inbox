Return-Path: <linux-kernel-owner+w=401wt.eu-S1760802AbWLHSNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760802AbWLHSNs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760801AbWLHSNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:13:48 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46990 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760788AbWLHSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:13:47 -0500
Date: Fri, 8 Dec 2006 19:03:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
In-Reply-To: <20061208174306.GA22299@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612081900050.3108@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235471170-git-send-email-jsipek@cs.sunysb.edu>
 <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
 <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr>
 <20061208021714.GA14363@filer.fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr>
 <20061208160038.GA17707@filer.fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0612081801240.20988@yvahk01.tjqt.qr>
 <20061208174306.GA22299@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 8 2006 12:43, Josef Sipek wrote:
>> On Dec 8 2006 11:00, Josef Sipek wrote:
>> 
>> +void __unionfs_mkdir(void *data)
>> +{
>> +	struct sioq_args *args = data;
>> +	struct mkdir_args *m = &args->mkdir;
>> +
>> +	args->err = vfs_mkdir(m->parent, m->dentry, m->mode);
>> +	complete(&args->comp);
>> +}
>> 
>> >> The members of m (i.e. m->*) are not modified as for as __unionfs_mknod goes.
>> >> vfs_mknod may only modify the members of m->parent (i.e. m->parent->*)
>> > 
>> >Yes they are. The return value is passed through a member of m.
>> 
>> Where - where do you see that m->parent, m->dentry or m->mode are modified?
>> (The original submission is above.)
>
>args->err is modified. If args is declared const, gcc complains.

I never said making "args" const, but
rather [-> http://lkml.org/lkml/2006/12/5/210 ] I said:

  "Care to make that: const struct mknod_args *m = &args->mknod;?"


	-`J'
-- 
