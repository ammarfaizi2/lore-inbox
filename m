Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTHWBTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTHWBTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:19:54 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:31395 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261346AbTHWBTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:19:51 -0400
Date: Sat, 23 Aug 2003 13:03:10 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review"	needs
 explaining to you?
In-reply-to: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1061600295.1890.21.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 10:05, Patrick Mochel wrote:
> > This is stable series, and /proc/acpi/sleep was fine for at least
> > entering S3 and swsusp. Anyway, if you killed sleep, you should kill
> > alarm as well. Its only usefull for sleeping, and IIRC it never worked
> > properly, anyway.
> 
> I will fix alarm. I will also update Nigel's suspend scripts (or release 
> others) that abstract the mechanism for entering sleep away from the user. 

Thanks for the credit, but they're not mine. I assume there's credit
already in the suspend.sh; I've never looked at it in much detail.

> > If you want to help, take a look at drivers/pci/power.c. That file
> > should not need to exist, but if I kill it bad stuff happens after
> > resume. Killing pm_register() and friends would be nice.

On this topic, can you guys please sort out for once and for all where
the code is going to end up. I'm trying to make the diff between 2.4 and
2.6 minimal. :>

> > > Secondly, you can actually remove the second command line parameter 
> > > ("noresume") by simply specifying a NULL partition to this parameter. It 
> > > requires about a 5-line change, and makes things simpler. 
> > 
> > You'd better not. You are expected to have one "resume=/foo/bar"
> > specified as append in lilo. You want to able to say noresume and do
> > one boot without resuming. Turning resume with
> > "resume=/dev/nonexistent" would be playing roulete with command line
> > argument order.
> 
> AFAIK, you could have
> 
> resume=/dev/hda3 always appended to your command line. Should you suspend 
> and not want to resume, you should be able to manually add
> 
> "resume=" on the command line after the above, and have the setup function 
> called again, which would reset it to NULL, thereby keeping the same 
> semantics as "noresume", but with less namespace pollution. Anyway, I'm 
> not going to do this now. I'll send you a patch if I do.

It would also break being able to fix the header - unless you like
having to mkswap after noresume :> (Unless you want us to remember the
value given by the first resume= parameter, but doesn't that negate the
logic to your argument?).

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

