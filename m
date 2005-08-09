Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVHIRFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVHIRFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVHIRFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:05:53 -0400
Received: from graphe.net ([209.204.138.32]:52106 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S964887AbVHIRFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:05:52 -0400
Date: Tue, 9 Aug 2005 10:05:48 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <1123559495.4370.87.camel@localhost>
Message-ID: <Pine.LNX.4.62.0508091002210.13054@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> 
 <Pine.LNX.4.62.0507272018060.11863@graphe.net>  <20050728074116.GF6529@elf.ucw.cz>
  <Pine.LNX.4.62.0507280804310.23907@graphe.net>  <20050728193433.GA1856@elf.ucw.cz>
  <Pine.LNX.4.62.0507281251040.12675@graphe.net>  <Pine.LNX.4.62.0507281254380.12781@graphe.net>
  <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz> 
 <Pine.LNX.4.62.0507281456240.14677@graphe.net>  <1123551167.9451.5.camel@localhost>
  <Pine.LNX.4.62.0508081858040.32489@graphe.net> <1123559495.4370.87.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Nigel Cunningham wrote:

> > No it wont. A process that has notifications to process should do that 
> > before being put into the freezer. Only after the notification list is 
> > empty will the process be notified and as long as the notification is 
> > pending no second notification should happen.
> 
> Sorry I wasn't clear. I was thinking of the case where a broken process
> doesn't process its todo list. (May it never be, but still...). How do
> we find out which one is broken? We need to traverse the todo list of
> every process, checking for outstanding freeze requests.

If a process does not handle its todo then you cannot freeze the process 
at all. Something very baaaad is going on. The current version gives up if 
a process cannot be frozen. This is still doing the same.

> Your reply leads me to another issue. It seems to me that you shouldn't
> wait until the todo list is empty before putting the freeze request on
> the todo list. If the todo list is ever used for something where it
> becomes hot, you might never see the todo list empty before your
> timeout, and freezing will be unreliable. Even if you do see it empty
> and insert your freeze request, it might be that more work is added
> afterwards, so you may as well just add the request whether or not the
> queue is empty.

Yes other tasks can be put on the notifier later. But the freeze notifier 
was first so the task is put to sleep and will run the other notifiers 
upon wakeup. The check is still okay. No additional notification should be 
added if the freeze notifier is already queued.

> > I am not sure how to sort that out. I guess post the current patches that 
> > you got and then we see how to continue from there.
> 
> Will do shortly. Just have to go talk to my boss first :> (Separate
> issue).

The patch you sent looks fine to me.

