Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272259AbTHNIGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTHNIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:06:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272259AbTHNIGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:06:16 -0400
Date: Thu, 14 Aug 2003 09:06:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
Message-ID: <20030814090605.A25516@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <m1he4kzpiy.fsf@frodo.biederman.org> <20030814085442.A21232@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814085442.A21232@infradead.org>; from hch@infradead.org on Thu, Aug 14, 2003 at 08:54:43AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 08:54:43AM +0100, Christoph Hellwig wrote:
> Why do we have shutdown at all?  Can't we just call ->remove on shutdown
> so the device always get's into proper unitialized state on shutdown, too?

That's likely to remove the keyboard driver, and some people like
to configure their box so that ctrl-alt-del halts the system, and
a further ctrl-alt-del reboots the system once halted.

There are also some bus drivers which want to know the difference
between "device (driver) was removed" and "device was shutdown",
eg, for setting bus-specific stuff back into a state where the
machine can be soft-rebooted.

With the shutdown callback, drivers get the option whether to
handle this event or not.  Combining it with remove gives them no
option what so ever, and bus drivers loose this knowledge.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

