Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJMLIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJMLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:08:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59654 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261605AbTJMLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:08:51 -0400
Date: Mon, 13 Oct 2003 12:08:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
Message-ID: <20031013120843.E19601@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com> <20031013040219.6ad71a57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031013040219.6ad71a57.akpm@osdl.org>; from akpm@osdl.org on Mon, Oct 13, 2003 at 04:02:19AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 04:02:19AM -0700, Andrew Morton wrote:
> Signals are for userspace and the signal developers shouldn't have to worry
> about weird in-kernel abuse and we have other simpler, more reliable
> mechanisms available in-kernel and even more such ranting you get the
> point.

Even so, how does the current signal code react to the case where
a userspace process installs (eg) a SIGINT handler immediately
before entering a region which it needs to clean up.  Meanwhile
a SIGINT is sent on some other CPU, discovers that there wasn't a
SIGINT handler when it looked, and queues a SIGKILL instead.
(this case was one which dwmw2 mentioned.)

I'm not certain if this can happen (the signal code is far to hairly
to work through the possibilities.)  However, we used to decide if
the signal was fatal to the process far later in the signal handling
(when delivering it to the user space process in the context of that
process) rather than in some other random context which may be on a
different CPU.

> Is there no way in which jffs2 can be weaned off this obnoxious habit?

jffs2 is using signal handlers as a method of communicating from user
space to kernel space.  Maybe it should create some sysfs files.
However, since there aren't any existing sysfs entities for jffs2 to
attach these files to, this wouldn't seem to be reasonable.

Maybe jffs2 needs /proc/fs/jffs2/<jffs2_instance>/foo but we all know
peoples feelings on procfs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
