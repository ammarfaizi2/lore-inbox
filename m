Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTEaP01 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTEaP01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:26:27 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21420 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264346AbTEaP00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:26:26 -0400
Date: Sat, 31 May 2003 08:39:40 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
Message-ID: <20030531153940.GA1280@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
References: <20030531095521.5576.CHRIS@heathens.co.nz> <20030531152133.A32144@infradead.org> <20030531144323.GA22810@work.bitmover.com> <20030531150150.GA14829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531150150.GA14829@suse.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 04:01:50PM +0100, Dave Jones wrote:
> Saving a line over readability is utterly bogus.

I agree 100%.  If you have anything more complex than

	if (error) return (error);

I want it to look like
	
	if ((expr) || (expr2) || (expr3)) {
		return (error);
	}

> Just look at some of the crap we have in devfs..

No kidding, look at the nested if, that's insane.

>     if (fs_info->devfsd_task == NULL) return (TRUE);
>     if (devfsd_queue_empty (fs_info) && fs_info->devfsd_sleeping) return TRUE;
>     if ( is_devfsd_or_child (fs_info) ) return (FALSE);
>     set_current_state (TASK_UNINTERRUPTIBLE);
>     add_wait_queue (&fs_info->revalidate_wait_queue, &wait);
>     if (!devfsd_queue_empty (fs_info) || !fs_info->devfsd_sleeping)
>         if (fs_info->devfsd_task) schedule ();
>     remove_wait_queue (&fs_info->revalidate_wait_queue, &wait);
>     __set_current_state (TASK_RUNNING);
>     return (TRUE);

I took a pass at this, I think this is better (note the use of 1/2 tabs
as "continuation" lines, that's a Sun thing and it works pretty well:

	if ((fs_info->devfsd_task == NULL) ||
	    (devfsd_queue_empty(fs_info) && fs_info->devfsd_sleeping)) {
		return (TRUE);
	}
	if (is_devfsd_or_child(fs_info)) return (FALSE);
	set_current_state (TASK_UNINTERRUPTIBLE);
	add_wait_queue (&fs_info->revalidate_wait_queue, &wait);
	if ((!devfsd_queue_empty (fs_info) || !fs_info->devfsd_sleeping) &&
	    fs_info->devfsd_task) {
	    	schedule();
	}
	remove_wait_queue(&fs_info->revalidate_wait_queue, &wait);
	__set_current_state(TASK_RUNNING);
	return (TRUE);

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
