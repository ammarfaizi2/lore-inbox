Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWBJNJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBJNJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWBJNJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:09:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:185 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932072AbWBJNJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:09:31 -0500
Subject: Re: RSS Limit implementation issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Feb 2006 23:07:26 +0000
Message-Id: <1139526447.6692.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-09 at 15:10 -0600, Ram Gupta wrote:
> I am working to implement enforcing RSS limits of a process. I am
> planning to make a check for rss limit when setting up pte. If the
> limit is crossed I see couple of  different ways of handling .
> 
> 1. Kill the process . In this case there is no swapping problem.

Not good as the process isn't responsible for the RSS size so it would
be rather random.

> 2. Dont kill the process but dont allocate the memory & do yield as we
> do for init process. Modify the scheduler not to chose the process
> which has already allocated rss upto its limit. When rss usage
> fallsbelow its limit then the scheduler may chose it again to run.
> Here there is a scenario when no page of the process has been freed or
> swapped out because there were enough free pages? Then we need a way
> to reschedule the process by forcefully freeing some pages or need to
> kill the process.

That is what I would expect. Or perhaps even allowing the process to
exceed the RSS but using the RSS limit as a swapper target so that the
process is victimised early. No point forcing swapping and the RSS limit
when there is free memory, only where the resource is contended ..

