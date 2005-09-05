Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVIEODR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIEODR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVIEODR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:03:17 -0400
Received: from thunk.org ([69.25.196.29]:14052 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751254AbVIEODQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:03:16 -0400
Date: Mon, 5 Sep 2005 10:03:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: real read-only [was Re: GFS, what's remaining]
Message-ID: <20050905140318.GA10751@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, David Teigland <teigland@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz> <20050905055428.GA29158@thunk.org> <20050905082735.GA2662@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905082735.GA2662@elf.ucw.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:27:35AM +0200, Pavel Machek wrote:
> 
> There's a better reason, too. I do swsusp. Then I'd like to boot with
> / mounted read-only (so that I can read my config files, some
> binaries, and maybe suspended image), but I absolutely may not write
> to disk at this point, because I still want to resume.
> 

You could _hope_ that the filesystem is consistent enough that it is
safe to try to read config files, binaries, etc. without running the
journal, but there is absolutely no guarantee that this is the case.
I'm not sure you want to depend on that for swsusp.

One potential solution that would probably meet your needs is a dm
hack which reads in the blocks in the journal, and then uses the most
recent block in the journal in preference to the version on disk.

						- Ted
