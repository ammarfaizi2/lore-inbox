Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUBHIeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 03:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUBHIeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 03:34:16 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:62511 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S262888AbUBHIeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 03:34:14 -0500
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Greg KH'" <greg@kroah.com>, "Hefty, Sean" <sean.hefty@intel.com>
Cc: "Troy Benjegerdes" <hozer@hozed.org>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Sun, 8 Feb 2004 00:31:56 -0800
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A10@mercury.infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040206185132.GG32116@kroah.com>
Importance: Normal
X-OriginalArrivalTime: 08 Feb 2004 08:34:13.0093 (UTC) FILETIME=[5484E150:01C3EE1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Friday, February 06, 2004 10:52 AM
>
> On Fri, Feb 06, 2004 at 08:42:14AM -0800, Hefty, Sean wrote:
> >
> > We want to continue to discuss specific details about what's needed to
> > add the code into the kernel.  Here's a list of modifications that I
> > think are needed so far:
> >
> > * Verify the use of spinlock calls.
> 
> Does this include "remove shim around spinlock calls"?  You should just
> call the kernel functions and not try to wrap them.

The spin lock abstraction was changed a while ago to use the 'spin_lock_bh'
functions rather than the 'spin_lock_irqsave' functions.  Is there still an
issue with using 'spin_lock_bh' that needs to be addressed - is the
abstraction still functionally broken?

There are two things that are accomplished with the spin lock abstraction.
The first is that it resolves to different things between kernel mode and
user mode, allowing code to be shared between both.  The second is debug
hooks that allow tracking who is holding the lock, etc, to aid in debugging.
I'm not a big fan of these debug hooks, so I think the whole spin lock
object could easily (and should) be changed to be a #define to the kernel
structure and functions.  I think there is value in allowing the code to be
shared between kernel mode and user mode.  Would using a macro that resolve
to the native kernel spin lock structure and functions be acceptable?

Thanks for your input,

- Fab

