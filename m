Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWIDOkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWIDOkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWIDOkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:40:51 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22225 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751421AbWIDOkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:40:49 -0400
Date: Mon, 4 Sep 2006 16:36:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
In-Reply-To: <1157379188.3384.926.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041624380.17279@yvahk01.tjqt.qr>
References: <1157031127.3384.791.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609031245240.31445@yvahk01.tjqt.qr>
 <1157379188.3384.926.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >+	offset += (2*sizeof(__be64) - 1);
>> 
>> >+#ifndef __LOPS_DOT_H__
>> >+#define __LOPS_DOT_H__
>> 
>> +struct gfs2_log_operations;
>> 
>> Making sure every .h file would "compile" on its own, this also means #include
>> <linux/list.h> for the below, f.ex..
>> 
>Is this really a requirement? I suspect there are a fair few exception
>to this over the kernel code.

A requirement - not yet. I could not find my own post about it, but this 
one is a similar one two years earlier http://lkml.org/lkml/2004/6/15/90

>> Maybe there should be at least one humna person listen in AUTHOR.
>> 
>Ok, I'll get back to you on that one :-)

Should have been "human" of course.

>Are you saying that they should all end in a , or that they should not,
>or even just that it should be consistent?

There seems to be no explicit CodingStyle rule at this point, so you are 
free to choose either. Just be consistent (like with the goto labels).

>> >+++ b/fs/gfs2/ops_address.c
>> >+	if (likely(file != &gfs2_internal_file_sentinal)) {
>> 
>> The thing is usually called "sentinel". Alan might prove me wrong that both
>> spelling variants are possible :-)
>> 
>I think you are right, so I've changed it.

http://dictionary.reference.com/search?q=sentinal&x=0&y=0
W.W.W.W.W.

>> >+static void stuck_releasepage(struct buffer_head *bh)
>> >+{
>> >+static unsigned limit = 0;
>> 
>> Is this really ok to have?
>> 
>I think so. I don't really care about the odd race here. All I want to
>do is ensure that in the (very unlikely, I hope) situation of this
>function being called, we don't land up generating huge amounts of
>debugging information. Usually only the first message will have the

There is printk_ratelimit() and SUBSYSTEM_ratelimit().

>useful information in it, so this was just to ensure that we are not
>flooded. I have made a slight change to it though. Let me know if you'd
>like some further changes in this area.


Jan Engelhardt
-- 
