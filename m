Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUJJPfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUJJPfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 11:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJJPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 11:35:45 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:13282 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268316AbUJJPfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 11:35:32 -0400
Message-ID: <5d6b657504101008351100aa53@mail.gmail.com>
Date: Sun, 10 Oct 2004 17:35:32 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Matthew Hindle <luminary@penguinmail.com>
Subject: Re: /proc/[number] special entries
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1097386284.7715.3.camel@chiyo.azumanga>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1097386284.7715.3.camel@chiyo.azumanga>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Sun, 10 Oct 2004 15:31:24 +1000, Matthew Hindle
<luminary@penguinmail.com> wrote:
> I was wondering if anybody could help me with a hint or two...
> 
> I'm trying to add a sub-directory to each /proc/[number] directory
> (where [number] is a process id). I think that I need to get a
> proc_dir_entry* so that I can call:
> 
> proc_mkdir("mysubdir", (struct proc_dir_entry *) parent);
> 
> However, I can't work out how to get a reference to the proc_dir_entry*
> I need. I can find the other entries in the proc directory (such as bus,
> cpuinfo. misc, net...) by doing something like this:
> 
> struct proc_dir_entry * dp;
> dp = &proc_root;
> dp = dp->subdir;
> while (dp != NULL) {
>   printk("er... found: %s\n",dp->name);
>   dp = dp->next;
> }
> 
> However, the only entries that don't show up are the [number] entries.
> Assistance please!

The PID entries in /proc are special cases: see proc_root_readdir().
I'm guessing though that you'll want to take a look at the struct
pid_entry stuff in fs/proc/base.c, it's all there.


Cheers,
Buddy

> Please CC: any replies to <luminary@penguinmail.com>.
> 
> Kind regards,
> Matt Hindle.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
