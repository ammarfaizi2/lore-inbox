Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVBUPZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVBUPZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVBUPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:25:38 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:59610 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262009AbVBUPZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:25:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mhQL0AmzYxR3PqMTBXkaaiFg6MUlf1UySC7whZQdzdVcKrh4y/+6iQJwYuCeu1QBs++LqPAVdF86nGHntoRnB5jxRiUJNmyKxJSUuqK1rEPqAl2jWHespvn5Cu/oBMJoqKjY7QKXtWYfdzSZEc2sEvCpKf9vlO5qk7Yk86JTW+8=
Message-ID: <58cb370e0502210725520eee3@mail.gmail.com>
Date: Mon, 21 Feb 2005 16:25:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Cc: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108998023.15518.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
	 <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
	 <cv36kk$54m$1@gatekeeper.tmr.com>
	 <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
	 <1108998023.15518.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Feb 2005 15:00:28 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-02-18 at 10:31, Kiniger, Karl (GE Healthcare) wrote:
> > Not entirely true (at least for me). I actually tried to read the
> > last iso9660 data sector with a small C program (reading 2 kb) and
> > it failed to read the sector. Using ide-scsi I was able to read it.....
> 
> Thats the bug that should now be fixed by the ide changes I did so that
> ide-cd has the knowledge ide-scsi has for partial completions of I/O

I haven't looked closely but I've noticed that these fixes are accessing rq->bio
directly which is a layering violation.  Could you de-bio and submit them?
[ AFAIR they are already splitted out in RHEL4 ]

Speaking about ide-scsi, it will be undeprecated after I fix the locking.
Rationale is that ide-scsi is _much_ simpler than ide-{cd,tape}.
[ although it doesn't support all the hardware that ide-{cd,tape} do ]

Bartlomiej
