Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTEaOpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTEaOpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:45:43 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:40084 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264405AbTEaOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:45:41 -0400
Date: Sat, 31 May 2003 16:01:50 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, Christoph Hellwig <hch@infradead.org>,
       Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
Message-ID: <20030531150150.GA14829@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
References: <20030531095521.5576.CHRIS@heathens.co.nz> <20030531152133.A32144@infradead.org> <20030531144323.GA22810@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531144323.GA22810@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 07:43:23AM -0700, Larry McVoy wrote:

 > One other one is the 
 > 
 > 	if (!q) return;
 > 
 > Chris said two lines, we don't do it that way.  The coding style we use is
 > a) one line is fine for a single statement.
 > b) in all other cases there are curly braces

Saving a line over readability is utterly bogus.
Just look at some of the crap we have in devfs..

    if (fs_info->devfsd_task == NULL) return (TRUE);
    if (devfsd_queue_empty (fs_info) && fs_info->devfsd_sleeping) return TRUE;
    if ( is_devfsd_or_child (fs_info) ) return (FALSE);
    set_current_state (TASK_UNINTERRUPTIBLE);
    add_wait_queue (&fs_info->revalidate_wait_queue, &wait);
    if (!devfsd_queue_empty (fs_info) || !fs_info->devfsd_sleeping)
        if (fs_info->devfsd_task) schedule ();
    remove_wait_queue (&fs_info->revalidate_wait_queue, &wait);
    __set_current_state (TASK_RUNNING);
    return (TRUE);

*horror* to my eyes at least.

Parts of the DRI code use similar uglies.  Whitespace is a *good* thing.
If you want more lines of code per screen, get a larger xterm, change a
font, whatever, but don't decrease code readability for something so bogus.

		Dave

