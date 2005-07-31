Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVGaWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVGaWbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGaW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:29:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261586AbVGaW2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:28:31 -0400
Date: Sun, 31 Jul 2005 18:27:52 -0400
From: Dave Jones <davej@redhat.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050731222751.GA28907@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Brown, Len" <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 01:03:56AM -0400, Brown, Len wrote:

 > But that believe would be total fantasy -- supsend/resume is not
 > working on a large number of machines, and no distro is currently
 > able to support it.  (I'm talking about S3 suspend to RAM primarily,
 > suspend to disk is less interesting -- though Red Hat doesn't
 > even support _that_)

After the 'swsusp works just fine' lovefest at OLS, I spent a little
while playing with the current in-tree swsusp implementation last week.

The outcome: I'm no more enthusiastic about enabling this in Red Hat
kernels than I ever was before.  It seems to have real issues with LVM
setups (which is default on Red Hat/Fedora installs these days).
After convincing it where to suspend/resume from by feeding it
the major/minor of my swap partition, it did actually seem
to suspend. And resume (though it did spew lots of 'sleeping whilst
atomic warnings, but thats trivial compared to whats coming up next).

I rebooted, and fsck found all sorts of damage on my / partition.
After spending 30 minutes pressing 'y', to fix things up, it failed
to boot after lots of files were missing.
Why it wrote anything to completely different lv to where I told it
(and yes, I did get the major:minor right) I have no idea, but
as it stands, it definitly isn't production-ready.

I'll look into it again sometime soon, but not until after I've
reinstalled my laptop.  (I'm just thankful I had the sense not to
try this whilst I was at OLS).

		Dave

