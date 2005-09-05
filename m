Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVIEHKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVIEHKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVIEHKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:10:05 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:62374 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S932263AbVIEHKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:10:03 -0400
Date: Mon, 5 Sep 2005 00:09:23 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
       David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905070922.GK21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz> <20050905055428.GA29158@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905055428.GA29158@thunk.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:54:28AM -0400, Theodore Ts'o wrote:
> In the ext3 case, the only time when read-only isn't quite read-only
> is when the filesystem was unmounted uncleanly and the journal needs
> to be replayed in order for the filesystem to be consistent.
Right, and OCFS2 is going to try to keep the behavior of only using the
journal for recovery in normal (soft) read-only operation.
Unfortunately other cluster nodes could die at any moment which can
complicate things as we are now required to do recovery on them to ensure
file system consistency.

Recovery of course includes things like orphan dir cleanup, etc so we need a
journal around for those transactions. To simplify all this, I'm just going
to have it load the journal as it normally does (as opposed to only when the
local node has a dirty journal) because it could be used at any moment.

Btw, I'm curious to know how useful folks find the ext3 mount options
errors=continue and errors=panic. I'm extremely likely to implement the
errors=read-only behavior as default in OCFS2 and I'm wondering whether the
other two are worth looking into.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
