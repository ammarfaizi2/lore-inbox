Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWIEJ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWIEJ7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWIEJ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:59:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965045AbWIEJ7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:59:04 -0400
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041624380.17279@yvahk01.tjqt.qr>
References: <1157031127.3384.791.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609031245240.31445@yvahk01.tjqt.qr>
	 <1157379188.3384.926.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041624380.17279@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 11:04:47 +0100
Message-Id: <1157450687.3384.976.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 16:36 +0200, Jan Engelhardt wrote:
> >> >+	offset += (2*sizeof(__be64) - 1);
> >> 
> >> >+#ifndef __LOPS_DOT_H__
> >> >+#define __LOPS_DOT_H__
> >> 
> >> +struct gfs2_log_operations;
> >> 
> >> Making sure every .h file would "compile" on its own, this also means #include
> >> <linux/list.h> for the below, f.ex..
> >> 
> >Is this really a requirement? I suspect there are a fair few exception
> >to this over the kernel code.
> 
> A requirement - not yet. I could not find my own post about it, but this 
> one is a similar one two years earlier http://lkml.org/lkml/2004/6/15/90
> 
Ok. I've had a go at that:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=f2f7ba5237e2fe10ba3e328a4f728b9e1ff141da

> >> Maybe there should be at least one humna person listen in AUTHOR.
> >> 
> >Ok, I'll get back to you on that one :-)
> 
> Should have been "human" of course.
> 
Yes, I'd realised that, its a question of which one to put in. Even
though I've been working on this for almost a year now, its still true
to say that Ken Preslan's code is more numerous than mine. So I'm not
sure that I should claim authorship for myself, on the other hand, if
this is a statement of where bug fixes should be sent, then I'm probably
as good a choice as any. There are of course a lot of other contributors
both from within Red Hat, and particularly since the review process
started, from outside Red Hat too.

> >Are you saying that they should all end in a , or that they should not,
> >or even just that it should be consistent?
> 
> There seems to be no explicit CodingStyle rule at this point, so you are 
> free to choose either. Just be consistent (like with the goto labels).
> 
Ok, now fixed in:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=ea67eedb211d3418fa62fe3477e0d19b2888225e

> >> >+++ b/fs/gfs2/ops_address.c
> >> >+	if (likely(file != &gfs2_internal_file_sentinal)) {
> >> 
> >> The thing is usually called "sentinel". Alan might prove me wrong that both
> >> spelling variants are possible :-)
> >> 
> >I think you are right, so I've changed it.
> 
> http://dictionary.reference.com/search?q=sentinal&x=0&y=0
> W.W.W.W.W.
> 
Yes, and my (rather small) treeware dictionary says likewise - its fixed
now anyway.

> >> >+static void stuck_releasepage(struct buffer_head *bh)
> >> >+{
> >> >+static unsigned limit = 0;
> >> 
> >> Is this really ok to have?
> >> 
> >I think so. I don't really care about the odd race here. All I want to
> >do is ensure that in the (very unlikely, I hope) situation of this
> >function being called, we don't land up generating huge amounts of
> >debugging information. Usually only the first message will have the
> 
> There is printk_ratelimit() and SUBSYSTEM_ratelimit().
> 
> >useful information in it, so this was just to ensure that we are not
> >flooded. I have made a slight change to it though. Let me know if you'd
> >like some further changes in this area.
> 
> 
> Jan Engelhardt

Hmm. I'm not sure that this would really be the right thing... what I
want is to limit the maximum number of times that this is triggered
rather than limiting the rate at which its triggered. I think thats a
subtle difference from the ratelimit functions,

Steve.


