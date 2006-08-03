Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWHCHrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWHCHrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWHCHrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:47:18 -0400
Received: from thunk.org ([69.25.196.29]:48079 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932375AbWHCHrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:47:17 -0400
Date: Thu, 3 Aug 2006 03:46:51 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Masover <ninja@slaphack.com>
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       Reiserfs-List@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
Message-ID: <20060803074651.GA27835@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Masover <ninja@slaphack.com>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	Andrew Morton <akpm@osdl.org>, vda.linux@googlemail.com,
	linux-kernel@vger.kernel.org, Reiserfs-List@namesys.com
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <20060801013104.f7557fb1.akpm@osdl.org> <44CEBA0A.3060206@namesys.com> <1154431477.10043.55.camel@tribesman.namesys.com> <20060801073316.ee77036e.akpm@osdl.org> <1154444822.10043.106.camel@tribesman.namesys.com> <44CF879D.1000803@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF879D.1000803@slaphack.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:55:57AM -0500, David Masover wrote:
> 
> If I understand it right, the original Reiser4 model of file metadata is 
> the file-as-directory stuff that caused such a furor the last big push 
> for inclusion (search for "Silent semantic changes in Reiser4"):

The furor was caused by concerns Al Viro expressed about
locking/deadlock issues that reiser4 introduced.  

The bigger issue with xattr support is two-fold.  First of all, there
are the progams that are expecting the existing extended attribute
interface, and not implementing it will simply mean that as far as
Samba, and other applications, Reiser4 simply will not haved xattr
support.

More importantly are the system-level extended attributes, such as
those used by SELINUX, which by definition are not supposed to be
visible to the user at all, but only are supposed to be there for the
SELINUX (or some other kernel layer, in general) to access.   

Not supporting xattrs means that those distro's that use SELINUX by
default (i.e., RHEL, Fedora, etc.) won't want to use reiser4, because
SELINUX won't work on reiser4 filesytstems.

Whether or not Hans cares about this is up to him....

						- Ted
