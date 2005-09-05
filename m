Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVIEGZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVIEGZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVIEGZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:25:57 -0400
Received: from thunk.org ([69.25.196.29]:20192 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932247AbVIEGZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:25:56 -0400
Date: Mon, 5 Sep 2005 01:54:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905055428.GA29158@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, David Teigland <teigland@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904203344.GA1987@elf.ucw.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 10:33:44PM +0200, Pavel Machek wrote:
> Hi!
> 
> > - read-only mount
> > - "specatator" mount (like ro but no journal allocated for the mount,
> >   no fencing needed for failed node that was mounted as specatator)
> 
> I'd call it "real-read-only", and yes, that's very usefull
> mount. Could we get it for ext3, too?

This is a bit of a degression, but it's quite a bit different from
what ocfs2 is doing, where it is not necessary to replay the journal
in order to assure filesystem consistency.  

In the ext3 case, the only time when read-only isn't quite read-only
is when the filesystem was unmounted uncleanly and the journal needs
to be replayed in order for the filesystem to be consistent.  Mounting
the filesystem read-only without replaying the journal could and very
likely would result in the filesystem reporting filesystem consistency
problems, and if the filesystem is mounted with the reboot-on-errors
option, well....

							- Ted
