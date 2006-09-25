Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWIYWf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWIYWf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWIYWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:35:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60298 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751104AbWIYWf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:35:28 -0400
Date: Tue, 26 Sep 2006 00:34:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060925223435.GA2540@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159220043.12814.30.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Nigel said:
> When will the lunacy end?

When people stop asking me for graphical progress.

Alternatively, when you strip down suspend2 patches so that they are
smaller than 2 * (sizeof(swsusp + uswsusp kernel parts)).

> > +	case SNAPSHOT_PMOPS:
> > +		switch (arg) {
> > +
> > +		case PMOPS_PREPARE:
> > +			if (pm_ops->prepare) {
> > +				error = pm_ops->prepare(PM_SUSPEND_DISK);
> > +			}
> > +			break;
...
> > +		default:
> > +			printk(KERN_ERR "SNAPSHOT_PMOPS: invalid argument %ld\n", arg);
> > +			error = -EINVAL;
> > +
> > +		}
> > +		break;
> > +
> >  	default:
> >  		error = -ENOTTY;
> 
> Guys! Why can't you see yet that all this uswsusp business is sheer
> lunacy? All of the important code is done in the kernel, and must be
> done in the kernel. Moving the little bit of high level logic that can
> be done in userspace to userspace doesn't mean you're doing the
> suspending in userspace.

Of course you are right. Fortunately for us, that high level logic is
80% of code. Unfortunately for you, that high level logic is where the
ugly parts are.... such as "press esc to abort". such as "image found,
do you want to reboot and try again or destroy it?".

> If you have to use userspace for suspending, use it for the things that
> don't matter, like the user interface, not the things that will break
> suspending and resuming if they break.

PMOPS_PREPARE (& friends) is "tell ACPI to light up that moon
symbol". Useful suspend can be done without that, but ACPI will be
confused on resume.

We could do it unconditionaly, but some machines have broken ACPI bioses.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
