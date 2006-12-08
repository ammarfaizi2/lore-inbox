Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425347AbWLHKr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425347AbWLHKr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425343AbWLHKr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:47:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34776 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425347AbWLHKrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:47:25 -0500
Date: Fri, 8 Dec 2006 11:38:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
In-Reply-To: <20061208021714.GA14363@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235471170-git-send-email-jsipek@cs.sunysb.edu>
 <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
 <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr>
 <20061208021714.GA14363@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-140295621-1165574293=:12227"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-140295621-1165574293=:12227
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 7 2006 21:17, Josef Sipek wrote:
>> >> > >+void __unionfs_mknod(void *data)
>> >> > >+{
>> >> > >+	struct sioq_args *args = data;
>> >> > >+	struct mknod_args *m = &args->mknod;

...
||||| vfs_mknod(m->parent, m->dentry, m->mode, m->dev);

>> >If I make the *args = data line const, then gcc (4.1) yells about modifying
>> >a const variable 3 lines down..
>> >
>> >args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
>> >
>> >Sure, I could cast, but that seems like adding cruft for no good reason.
>> 
>> No I despise casts more than missing consts. Why would gcc throw a warning?
>> Let's take this super simple program
>
>No, this program doesn't tickle the problem.. Try to compile this one:

The members of m (i.e. m->*) are not modified as for as __unionfs_mknod goes.
vfs_mknod may only modify the members of m->parent (i.e. m->parent->*)

>
><<<
>struct mknod_args {
>	int mode;
>	int dev;
>};
>
>void  __mknod(const void *data)
>{
>	const struct mknod_args *args = data;
>	args->mode = 0;
>}
>
>int main(void) {
>	const struct mknod_args *m;
>	__mknod(m);
>	return 0;
>}
>>>>
>
>$ gcc -Wall -c test.c
>test.c: In function âmknodâtest.c:10: error: assignment of read-only location
>
>
>Josef "Jeff" Sipek.
>
>-- 
>Reality is merely an illusion, albeit a very persistent one.
>		- Albert Einstein
>

	-`J'
-- 
--1283855629-140295621-1165574293=:12227--
