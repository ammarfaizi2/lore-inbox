Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVJNEzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVJNEzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJNEzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:55:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:7044 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751317AbVJNEzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:55:52 -0400
Date: Fri, 14 Oct 2005 06:56:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014045615.GC13595@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu> <1129242595.4623.14.camel@cmn3.stanford.edu> <1129256936.11036.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129256936.11036.4.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> #!/bin/bash
> while true ; do
>     START=`date +"%s"`
>     sleep 10
>     END=`date +"%s"`
>     let DIFF=END-START
>     echo "$DIFF" >>time
>     echo "---"
> done
> 
> I'm attaching what I found when I got back.

> 1
> 10
> 6
> 0
> 0

could you try:

	strace -o log sleep 10

and wait for a failure, and send us the log? Is it perhaps nanosleep 
unexpectedly returning with -EAGAIN or -512? There's a transient 
nanosleep failure that happens on really fast boxes, which we havent 
gotten to the bottom yet. That problem is very sporadic, but maybe your 
box is just too fast and triggers it more likely :-)

	Ingo
