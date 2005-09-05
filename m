Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVIEI1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVIEI1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIEI1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:27:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4073 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932280AbVIEI1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:27:49 -0400
Date: Mon, 5 Sep 2005 10:27:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, David Teigland <teigland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: real read-only [was Re: GFS, what's remaining]
Message-ID: <20050905082735.GA2662@elf.ucw.cz>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz> <20050905055428.GA29158@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905055428.GA29158@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > - read-only mount
> > > - "specatator" mount (like ro but no journal allocated for the mount,
> > >   no fencing needed for failed node that was mounted as specatator)
> > 
> > I'd call it "real-read-only", and yes, that's very usefull
> > mount. Could we get it for ext3, too?
> 
> This is a bit of a degression, but it's quite a bit different from
> what ocfs2 is doing, where it is not necessary to replay the journal
> in order to assure filesystem consistency.  
> 
> In the ext3 case, the only time when read-only isn't quite read-only
> is when the filesystem was unmounted uncleanly and the journal needs
> to be replayed in order for the filesystem to be consistent.

Yes, I know... And that is going to be a disaster when you are
attempting to recover data from failing harddrive (and absolutely do
not want to write there).

There's a better reason, too. I do swsusp. Then I'd like to boot with
/ mounted read-only (so that I can read my config files, some
binaries, and maybe suspended image), but I absolutely may not write
to disk at this point, because I still want to resume.

Currently distros do that using initrd, but that does not allow you to
store suspended image into file, and is slightly hard to setup.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
