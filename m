Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTFYSFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTFYSFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:05:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:6408 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264898AbTFYSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:05:41 -0400
Date: Wed, 25 Jun 2003 19:19:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI
Message-ID: <20030625191949.A1140@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625165513.A20328@infradead.org> <3EF9DE23.2080806@aros.net> <20030625184423.A29537@infradead.org> <3EF9E6EA.6050901@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EF9E6EA.6050901@aros.net>; from ldl@aros.net on Wed, Jun 25, 2003 at 12:16:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 12:16:10PM -0600, Lou Langholtz wrote:
> >Hey, I didn't say changing the interface is wrong.  But if possible
> >do it in a way that the new userspace can still support the old kernel
> >driver.
> >
> Agreed! Will do, but how???

if (detected_new_driver) {
   new_code();
} else {
   old_code();
}

in the userland app.  if structures change in an incompatible way
you need _v1 and _v2 versions of them of course.

And what to use for detected_new_driver?  Probably the new ABI version
ioctl..

> Cool! I'll take a look at these. Is this the prefered way then? There's 
> probably a lot of need for this generally speaking.

Yeah.  And please do like device-mapper with major and minor versions.
major as in completly incompatible and minor as in support old protocol
but has new featues in addition.

> Thought about using 
> /proc for this too.

Bad idea :)

> And then sysfs is gaining favor so maybe in there? 

Doesn't sound like a fit either.  Maybe you could do a small own fs
to control nbd, but I'm not familar enough with the actual API to comment
on this more.

