Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264751AbUEYLqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbUEYLqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 07:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbUEYLqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 07:46:14 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:35802 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264751AbUEYLp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 07:45:56 -0400
From: "braam" <braam@clusterfs.com>
To: "'Lars Marowsky-Bree'" <lmb@suse.de>, "'Jens Axboe'" <axboe@suse.de>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch
Date: Tue, 25 May 2004 19:45:24 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRCRn1EDT5JHeVGSx+PhgksJmVcCgAA6sYg
In-Reply-To: <20040525105252.GJ22750@marowsky-bree.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040525114549.B8EF731012F@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars, 

> -----Original Message-----
> From: Lars Marowsky-Bree [mailto:lmb@suse.de] 
> Sent: Tuesday, May 25, 2004 6:53 PM
> To: braam; 'Jens Axboe'
> Cc: torvalds@osdl.org; akpm@osdl.org; 
> linux-kernel@vger.kernel.org; 'Phil Schwan'
> Subject: Re: [PATCH/RFC] Lustre VFS patch
> 
> On 2004-05-25T16:21:29,
>    braam <braam@clusterfs.com> said:
> 
> > I think do answer your question:  ...
> > > > If we were to return errors, (which, I agree, _seems_ much more 
> > > > sane, and we _did_ try that for a while!) then there is a good 
> > > > chance, namely immediately when something is flushed to 
> disk, that 
> > > > the system will detect the errors and not continue to execute 
> > > > transactions making consistent testing of our replay mechanisms 
> > > > impossible.
> > So: we can use the flags, but we cannot return the errors.
> 
> Maybe I am missing something here, but is this testing not 
> somewhat unrealistic then? In the general case, the system in 
> production _will_ report an error and not silently throw away 
> the writes.

I would not say "unrealistic": It is a harsh way to systematically and
consistently generate failure patterns that are otherwise subject to winning
races with the flushing daemons. 

Semantically what we add a new flag: 
 IGNORE_IO_ERRORS
The ioctl in our patch has the same effect as setting IGNORE_IO_ERRORS |
RDONLY

Is it really terrible to have that flag?

> > Some people find it very convenient to have this available, 
> but if the 
> > opinion is that it is better to let development teams 
> manage their own 
> > testing infrastructure that is acceptable to me.
> 
> Yes, this is very "convenient" and actually, "some people" 
> think it is absolutely mandatory that the kernel which is 
> used for production sites is 1:1 bit-wise identical than the 
> one used for load & stress testing, otherwise the testing is 
> void to a certain degree...
> 
> Maybe you could fix this in the test harness / Lustre itself 
> instead and silently discard the writes internally if told so 
> via an (internal) option, instead of needing a change deeper 
> down in the IO layer, or use a DM target which can give you 
> all the failure scenarios you need?
> 
> In particular the last one - a fault-injection DM target - 
> seems like a very valuable tool for testing in general, but 
> the Lustre-internal approach may be easier in the long run.

Yes, a (virtual) block device can do this easily.  If Jens can accept the
new flag that is easiest, if not we will hack up a DM target in due course.

- Peter -

