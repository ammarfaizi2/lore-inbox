Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTIIBTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbTIIBTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:19:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5093 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262377AbTIIBTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:19:34 -0400
Message-Id: <200309090119.h891JS307266@owlet.beaverton.ibm.com>
To: Timothy Miller <miller@techsource.com>
cc: Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling 
In-reply-to: Your message of "Mon, 08 Sep 2003 20:06:04 EDT."
             <3F5D196C.2040202@techsource.com> 
Date: Mon, 08 Sep 2003 18:19:28 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Yeah, I didn't think his comment was very helpful since I thought it was 
    clear that I was working on a draft of an IDEA.

How complex is your thinking where *ideas* need drafts? :)

A scheduler which modifies behavior based on its load is not unreasonable,
but it doesn't need a neural net to do so.  We just have to tell
it what's important.  To do that, WE have to know what's important.
And we haven't figured that all out yet.

For example, just-completed I/O by xmms, even though xmms performs
lots of I/O, is important, but just-completed I/O by the db app, which
also performs lots of I/O, is not. Well, unless you're on the server
instead of the laptop; then the db app is important.  Does there exist
sufficient context about the two types of processes that we, the human,
can make a decision?  Everything I've seen so far is just "well, that's
just what *I* want in that situation."  If so, we'll never get that right
even with a neural net.

However, once we characterize "what we want" we might be able to
communicate it (and code it) to the kernel.  To that end, here's an
update on scheduler statistics code.  In testing, it's proved fairly
non-intrusive and may provide some answers to "what we want".  If it
doesn't, it's fairly extensible if done carefully.

    http://eaglet.rain.com/rick/linux/schedstat/

This patch (against 2.6.0-test4 or 2.6.0-test5) collects data about
scheduler decisions, which may allow us, with 20/20 hindsight, to
determine which specific decisions we don't like and perhaps how to
modify them.

Rick
