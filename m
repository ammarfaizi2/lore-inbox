Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUDVCYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUDVCYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 22:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUDVCYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 22:24:10 -0400
Received: from smtp.gentoo.org ([128.193.0.39]:14296 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S263784AbUDVCYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 22:24:06 -0400
From: Jason Cox <steel300@gentoo.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
In-Reply-To: <Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org>
References: <E1BFhPh-00027s-IL@smtp.gentoo.org>
	<Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org>
Organization: Gentoo
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1BGTsk-0000va-Bx@smtp.gentoo.org>
Date: Thu, 22 Apr 2004 02:24:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004 21:14:38 +0100 (BST)
James Simmons <jsimmons@infradead.org> wrote:

> 
> > Often, I have wondered what the need for 64 tty devices in /dev is.
> > I began tinkering with the code and am wondering why it's not user
> > configurable. I came up with a quick patch to add it as an option
> > under drivers/char/Kconfig. I also made a lower bound of 12. If this
> > is an idea worth pursuing, please let me know. If this idea has been
> > rejected before, I apologize. What do you think of this idea?
> 
> The reason for 64 is that the major number is shared between the
> serial tty and VT tty drivers. The first 64 to Vts and the rest to
> serial devices. 

First off, thanks for the reply. Does lowering the number of tty devices
interfer with the creation of serial consoles? Can't they start at the
same major number without an issue?

> What is even more is that there exist ioctls that return shorts 
> which means only 16 VCs can be accounted for on a VT. 

So is my limit wrong? Should I up the lower limit to 16 to account for
this? 

> When the kernel supports multi-desktop systems we will have to deal
> with the serial and VT issue. Most likely the serial tty drivers will
> be given a different major number. 

Why isn't this done now?

> I personally believe that because
> of the 16 bit limit that there should be 16 VCs per VT terminal. 

That does make sense.

Just a side note: I have been running with 12 (0 - 11) tty devices
without issue. I haven't tried a serial console, but will shortly, just
to see if it interferes with serial console creation.

Thanks,
Jason Cox

