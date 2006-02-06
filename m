Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWBFJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWBFJGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBFJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:06:41 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:2193 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S1750809AbWBFJGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:06:40 -0500
Date: Mon, 6 Feb 2006 17:05:47 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206090547.GJ8154@blackham.com.au>
References: <200602030918.07006.nigel@suspend2.net> <200602041451.45232.rjw@sisk.pl> <20060204192123.GB3909@elf.ucw.cz> <200602042057.45369.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602042057.45369.rjw@sisk.pl>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 08:57:44PM +0100, Rafael J. Wysocki wrote:
> > What about this (untested)?
> 
> So you think we should chroot from the user space.  Fine.

Here's what suspend2's userspace user interface currently does
before suspending.

static void enforce_lifesavers() {
    struct rlimit r;
    r.rlim_cur = r.rlim_max = 0;
    setrlimit(RLIMIT_NOFILE, &r);
    setrlimit(RLIMIT_NPROC, &r);
    setrlimit(RLIMIT_CORE, &r);
}   

All userspace user interfaces (text, fbsplash, usplash) share this
common code that is run before suspend itself proceeds.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
