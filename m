Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVBGG7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVBGG7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVBGG7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:59:35 -0500
Received: from almesberger.net ([63.105.73.238]:24073 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261367AbVBGG7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:59:33 -0500
Date: Mon, 7 Feb 2005 03:57:07 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andi Kleen <ak@suse.de>
Cc: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050207035707.C25338@almesberger.net>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro> <20050121071144.GB657@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121071144.GB657@wotan.suse.de>; from ak@suse.de on Fri, Jan 21, 2005 at 08:11:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> It's dependent on the architecture already. I would like to enable
> it on i386/x86-64 because the kernel command line is often used
> to pass parameters to installers, and having a small limit there
> can be awkward.

Something to keep in mind when extending the command line is that
we'll probably need a mechanism for passing additional (and
possibly large) data blocks from the boot loader soon.

The reason for this is that, if booting through kexec, it would be
attractive to pass device scan results, so that the second kernel
doesn't have to repeat the work. As an obvious extension, anyone
who wants to boot *quickly* could also pass such data from
persistent storage without actually performing the device scan at
all when the machine is booted.

The command line may be suitable for this, but to allow for passing
a lot of data, its place in memory should perhaps just be reserved,
at least until the system has passed initialization, without trying
to copy it to a "safe" place early in kernel startup.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
