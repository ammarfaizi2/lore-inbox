Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTDKNPb (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTDKNPa (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:15:30 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:46464 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264352AbTDKNPa (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 09:15:30 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111329.h3BDTN1P000878@81-2-122-30.bradfords.org.uk>
Subject: Re: [RFC] first try for swap prefetch
To: zwane@linuxpower.ca (Zwane Mwaikambo)
Date: Fri, 11 Apr 2003 14:29:23 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       schlicht@uni-mannheim.de (Thomas Schlichter),
       akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.50.0304110819180.540-100000@montezuma.mastecende.com> from "Zwane Mwaikambo" at Apr 11, 2003 08:22:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually, it could potentially do something very useful - if you are
> > using a laptop, or other machine where disks are spun down to save
> > power, you might be swapping in data while the disk still happens to
> > be spinning, rather than letting it spin down, then having to spin it
> > up again - in that instance you are definitely gaining something,
> > (more battery life).
> 
> That sounds like a rather short disk spin down time (in which case you 
> might not be gaining all that much battery life given the constant spin 
> up/down), either that or you're paging in way too much stuff.

Sure, it's probably not going to happen with normal usage, but say
you're using a large application, then load a web browser to read the
documentaion, and part of the large application is swapped out.  Once
the web browser has loaded, it might free some RAM, and then you spend
10 minutes reading the documentation.  The disk might spin down after
five minutes, and then have to spin back up again when you switch back
to your main application.  We could possibly avoid this by swapping
the pages back in after one minute of inactivity, then letting the
disk spin down.

Infact, we could spin down the disk _immediately_, if we find that we
can swap all of the pages back in to physical RAM.  Of course, that
would only make sense if the disk is being used primarily for swap,
but it's a scenario where we could do better than we are at the
moment.

John.
