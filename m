Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVAJXdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVAJXdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVAJXaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:30:02 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:50701 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262751AbVAJXYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:24:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oyqNUkqPnJs9V/Y7qBuzgCakucwGi1mFp0YDXYQ/S/dlri2jNCzMQv1U8oIxY9fm2NuvJ82mtRl+TT0tzX9KpBYyb+AmARH0dLnD1tEnRK0+gTCVMl5ap1lOf8FSoZXol6BH1iadi96UsBM3J4ccTyo8XP99zqFrRr+NNiN7kUU=
Message-ID: <3f250c71050110152421e83e04@mail.gmail.com>
Date: Mon, 10 Jan 2005 19:24:35 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: User space out of memory approach
Cc: Edjard Souza Mota <edjard@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20050110200514.GA18796@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 18:05:14 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> On Tue, Jan 11, 2005 at 12:40:24AM +0200, Edjard Souza Mota wrote:
> > Hi,
> >
> > I guess it the idea was not fully and well explained. It is not the OOM Killer
> > itself that was moved to user space but rather its ranking algorithm.
> > Ranking is not an specific functionality of kernel space. Kernel only need
> > to know which process whould be killed.
> >
> > In that sense the approach is different and might be worth testing, mainly for
> > cases where we want to allow better policies of ranking. For example, an
> > embedded device with few resources and important different running applications:
> > whic one is the best? To my understanding the current ranking policy
> > does not necessarily chooses the best one to be killed.
> 
> Sorry, I misunderstood. Should have read the code before shouting.
> 
> The feature is interesting - several similar patches have been around with similar
> functionality (people who need usually write their own, I've seen a few), but none
> has ever been merged, even though it is an important requirement for many users.
> 
> This is simple, an ordered list of candidate PIDs. IMO something similar to this
> should be merged. Andrew ?
> 
> Few comments about the code:
> 
>  retry:
> -       p = select_bad_process();
> +       printk(KERN_DEBUG "A good walker leaves no tracks.\n");
> +       p = select_process();
> 
> You want to fallback to select_bad_process() if no candidate has been selected at
> select_process().
The idea is turn off the select_bad_process() and the new
select_process() will get the list of pids to be killed from
/proc/oom. But the ranking algorithms is the same, I mean is the Rik
van Riel algorithm. Do you think it is worthwhile to maintain the
select_bad_process (kernel space algorithm) if we have the
select_process() function?

> 
> You also want to move "oom" to /proc/sys/vm/.

This can be possible. Do you think that it is a good place to move the oom?

BR,

Mauricio Lin.
