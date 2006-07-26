Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWGZAUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWGZAUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWGZAUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:20:39 -0400
Received: from dvhart.com ([64.146.134.43]:63418 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030290AbWGZAUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:20:38 -0400
Message-ID: <44C6B555.7000300@mbligh.org>
Date: Tue, 25 Jul 2006 17:20:37 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>	 <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu>	 <200607131521.52505.ak@suse.de>	 <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org> <1153853342.4725.21.camel@localhost>
In-Reply-To: <1153853342.4725.21.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-07-13 at 12:05 -0700, Linus Torvalds wrote:
> 
>>Doing core-dumping in user space would be insane. It doesn't give _any_ 
>>advantages, only disadvantages.
> 
> 
> It has a number of very real advantages in certain circumstances and the
> only interface the kernel needs to provide is the debugger interface and
> something to "kick" the debugger and reparent to it, or for that matter
> it might even be viable just to pass the helper the fd of an anonymous
> file holding the dump.
> 
> Taking out the kernel core dump support would be insane.
> 
> We get customers who like to collect/process/do clever stuff with core
> dumps and failure cases. We also get people who want to dump a core that
> excludes the 14GB shared mmap of the database file as another example
> where it helps.

The in-kernel core dumper also seems to hold locks that wedge access
to /proc for that pid, which causes anything walking /proc to wedge.
For large core dumps, that takes far too long, and causes us real
problems

M.
