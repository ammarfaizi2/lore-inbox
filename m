Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVBUMfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVBUMfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBUMfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:35:11 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:32008 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261959AbVBUMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:35:02 -0500
Date: Mon, 21 Feb 2005 20:34:25 +0800 (WST)
From: raven@themaw.net
To: Valdis.Kletnieks@vt.edu
cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] automount does not close file descriptors at start 
In-Reply-To: <200502210527.j1L5RX44032376@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0502212013230.8143@donald.themaw.net>
References: <20050216125350.GA6031@uio.no>           
 <Pine.LNX.4.58.0502211244540.9892@wombat.indigo.net.au>
 <200502210527.j1L5RX44032376@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-100.6, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 21 Feb 2005 12:57:22 +0800, Ian Kent said:
>
>> This is the first time I've heard this and the first time I wrote a Unix
>> daemon was fifteen years ago.
>>
>> As far as I'm concerned redirecting stdin, stdout and stderr to the null
>> device, then closing it and setting the process to a be the group leader
>> (as autofs does) should be all that's needed to daemonize a process.
>>
>> So are we saying that we don't trust the kernel to reliably duplicate the
>> state of file handles when we fork?
>
> No, you have it 180 degrees off. ;)

Perhaps the sentence above should start "So you are saying that ...".

I'm arguing that I should'nt have to perform a loop closing file 
descriptors I haven't opened.

>
> We *do* trust the kernel to reliably duplicate the state of file handles.

This confirms above.

> So if we're about to do the whole double-fork thing and all that, we want to
> loop around and close all the file descriptors we don't want leaking to
> the double-forked daemon.  Yes, we do something reasonable with fd 0,1,2 -
> but we probably also want to do something with that unclosed fd 3 that's still
> open on /etc/mydaemon.cf, and any other file descriptors we've left dangling
> in the breeze after initialization.

Now this is a good point.

I don`t do a double fork in autofs (inherited code), although, long ago I 
did.

Do we really need to do a double fork to disassociate from the controlling 
terminal or is a single fork and close etc. enough?

I notice that "setsid()" should do this but I've not seen it bofore.
Is that sufficient to do the job instead of the double fork?

And it looks like the automount process I just started still has a tty, 
grumble ....

Ian

