Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbUKXXtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbUKXXtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbUKXXrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:47:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56044 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262943AbUKXXpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:45:03 -0500
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124131218.GA12868@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294252.5805.228.camel@desktop.cunninghams>
	 <20041124131218.GA12868@infradead.org>
Content-Type: text/plain
Message-Id: <1101333120.3895.71.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:52:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 00:12, Christoph Hellwig wrote:
> >  /*
> >   * Platforms implementing 32 bit compatibility ioctl handlers in
> > - * modules need this exported
> > + * modules need this exported. So does Suspend2 (when made as
> > + * modules), so the export_symbol is now unconditional.
> >   */
> > -#ifdef CONFIG_COMPAT
> >  EXPORT_SYMBOL(sys_ioctl);
> > -#endif
> 
> This is definitly the wrong interface for whatever you want to do.

Do you know what I want to do?

Frankly, I actually agree. I'd rather use vt_console_print and gotoxy
directly to do the display of information that doesn't need to clutter
the logs, but when I first submitted code for doing that, people
suggested using /dev/console instead. That makes using these syscalls
necessary.

> > +EXPORT_SYMBOL(proc_match);
> 
> Also nothing anything outside of procfs internals should do.

This was because, following the "use files" methodology above, I have to
be able to find the file I want to use (/proc/splash) even when /proc
isn't mounted yet. I'll happily just call splash_write_proc.

> >  unsigned long avenrun[3];
> > +EXPORT_SYMBOL(avenrun);
> 
> Nothing you should poke into.

Mmm. Commented on this elsewhere. Perhaps rather than saving and
restoring the values, I should inhibit them being updated? If the BIOS
was doing the suspending/resuming, we wouldn't object to them not being
updated. Does that sound like a better solution? (Remember the aim was
avoid making sendmail etc refuse to work for a while because the load
average is too high).

> > +/* Exported for Software Suspend 2 */
> > +EXPORT_SYMBOL(nr_free_highpages);
> > +EXPORT_SYMBOL(pgdat_list);
> 
> Dito.

Used for preparing the image.

> > +EXPORT_SYMBOL(swap_free);
> > +EXPORT_SYMBOL(swap_info);
> > +EXPORT_SYMBOL(sys_swapoff);
> > +EXPORT_SYMBOL(sys_swapon);
> > +EXPORT_SYMBOL(si_swapinfo);
> > +EXPORT_SYMBOL(map_swap_page);
> > +EXPORT_SYMBOL(get_swap_page);
> > +EXPORT_SYMBOL(get_swap_info_struct);
> 
> Dito.  Lowlevel swapdevice access isn't something modules should poke
> into.

It is if they're writing to swap.

> Nigel, why do I have this strange feeling that exactly the same patch
> was rejected already but you resubmitted it again?

Not exactly the same but yes, substantially. I listened then to the
comments and applied changes. I'm listening now. Unfortunately, though,
you just reject things outright without even discussing why they're
there or whether there's a better way I might not have thought of. I
freely admit that I'm not the world's greatest Linux guru; that's part
of why I'm submitting these patches now for review. Could you please try
to be more helpful? I'll promise to be receptive!

> If you want anything merged drop the modular swsusp bits, I doubt it'll
> ever be merged.

Aside from other advantages (quicker development etc), the modular bits
allow you to free about 150k (debugging compiled in) when you're not
suspending. I thought that was well worth the little bit of extra code.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

