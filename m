Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTHWIAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 04:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHWIAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 04:00:44 -0400
Received: from users.linvision.com ([62.58.92.114]:46306 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S261711AbTHWIAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 04:00:42 -0400
Date: Sat, 23 Aug 2003 09:55:21 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, davej@codemonkey.org.uk,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
       aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030823095521.B14519@bitwizard.nl>
References: <20030822135946.GA2194@elf.ucw.cz> <20030822155207.A17469@infradead.org> <20030822195427.GB2306@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822195427.GB2306@elf.ucw.cz>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:54:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > +/* driver entry point for term */
> > > +static void __exit
> > > +drv_exit(void)
> > > +{
> > > +	dprintk(KERN_INFO PFX "drv_exit\n");
> > > +
> > > +	cpufreq_unregister_driver(&cpufreq_amd64_driver);
> > > +	if (ppst) {
> > > +		kfree(ppst);
> > 
> > kfree(NULL) is fine.
> > 
> > > +		ppst = 0;
> > 
> > this should be ppst = NULL but in fact is completly superflous as
> > the module is gone afterwards.
> 
> Ok.

Guys, good programming practise would leave this in. If you want,
you could add a comment that in the current code, this is superfluous. 

In the current code it is also not performance critical. So to maintain
good programming practise I would recommend to leave the ppst = NULL. 

The code might get copied somewhere else. In that case the ppst=NULL
will indicate that it's pointing nowhere. Also, this will prevent
the bug from becoming a bug: The developer will immediately see that
he's made a mistake and fix it before it becomes a real bug. But
if you leave the dangling pointer around, you will address memory
that until recently contained believable data. So it will work
most of the time. Only when an interrupt comes by  that allocates
memory and actually writes the relevant parts will you get problems.
That might be quite rare and very difficult to track down. 

In writing code, simple bugs are not a problem. These are the bugs
that show up while compiling the code, or in first testing. 

You should try to prevent the hard bugs with good programming 
practise. These are the bugs where you get a report: My server
locks up every day or two. It's too long to sit by the machine 
to wait for it to happen, it's too long to log everything, but 
it's way too short to say: Sorry, you'll have to live with it.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
