Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbTDJX2T (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTDJX2T (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:28:19 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:4800 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264247AbTDJX2R (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:28:17 -0400
Date: Fri, 11 Apr 2003 11:36:56 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: Fixes for ide-disk.c
In-reply-to: <1050011724.12930.138.camel@dhcp22.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1050017816.2629.8.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
 <1049570711.3320.2.camel@laptop-linux.cunninghams>
 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
 <20030410183839.GC4293@zaurus.ucw.cz>
 <1050011724.12930.138.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

As far as ide code goes, I'm trying to:

1) Get rid of messages that don't need to appear during suspend (so the
'nice display' looks nice (hence printk changes)
2) Make sure the data actually does make it to disk before we poweroff
(hence write back cache interest)
3) Make sure ide_suspend/unsuspend do the right thing (however that's
defined).

I hadn't looked at the code yet to see why it's called twice - too busy
with other things. I did wonder if 

        device_suspend(4, SUSPEND_NOTIFY);
        device_suspend(4, SUSPEND_SAVE_STATE);
        device_suspend(4, SUSPEND_DISABLE);

might do it, but it's an untested theory.

Regards,

Nigel

On Fri, 2003-04-11 at 09:55, Alan Cox wrote:
> On Thu, 2003-04-10 at 19:38, Pavel Machek wrote:
> > Hi!
> > 
> > > > Okay. We need a different solution then, but the problem remains - the
> > > > driver can get multiple, nexted calls to block and unblock. Can it
> > > > become a counting lock?
> > > 
> > > Blocked is a binary power management described state, its not a lock.
> > > What are you actually trying to do ?
> > 
> > He's trying to fix swsusp. Just now it likes
> > to BUG() for some people.
> 
> I meant at a slightly lower and more detailed level
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

