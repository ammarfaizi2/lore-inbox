Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUKWFAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUKWFAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKWEsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:48:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61907 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262317AbUKVVlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:41:14 -0500
Date: Mon, 22 Nov 2004 13:41:07 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: janitor@sternwelten.at, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/4]  char/snsc: reorder set_current_state() and 	add_wait_queue()
Message-ID: <20041122214107.GD7770@us.ibm.com>
References: <E1CVLHE-0002XB-AH@sputnik> <20041122205620.GA5806@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122205620.GA5806@admingilde.org>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:56:20PM +0100, Martin Waitz wrote:
> hoi :)
> 
> On Sat, Nov 20, 2004 at 03:47:03AM +0100, janitor@sternwelten.at wrote:
> > Description: Reorder add_wait_queue() and set_current_state() as a
> > signal could be lost in between the two functions.
> 
> couldn't you loose a wake event that way?

The patch in question was made specifically because the given code may
miss wake events. Hence the reorder and my description. Since I'm not an
expert on locking, I asked Oliver Neukum about this exact issue a while
ago. Here is his response:

--------

>Am Mittwoch, 15. September 2004 19:34 schrieb Nishanth Aravamudan:
> Oliver,
> 
> It was recommended to me to ask you a question about the proper ordering
> of add_wait_queue() and set_current_state().
> 
> In some drivers the order is
> 
> set_current_state(TASK_INTERRUPTIBLE);
> add_wait_queue(...);

That is correct.

> and in others it is
> 
> add_wait_queue(...);
Here in between is a window in which a wake up would be missed.
> set_current_state(TASK_INTERRUPTIBLE);
> 
> It seems like one of these should be oorrect and not the other, but I'm
> not sure which is which. Any insight you could provide would be greatly
> appreciated.

Iff you test whether you should indeed sleep before you call schedule,
it doesn't matter. In the other case, you need to use the first form.

-------

Hope that clears things up a bit.

-Nish
