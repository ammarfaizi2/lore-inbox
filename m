Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTF2OGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbTF2OGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:06:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15108 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262032AbTF2OGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:06:42 -0400
Date: Sun, 29 Jun 2003 16:20:47 +0200
From: Willy TARREAU <willy@w.ods.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Willy TARREAU <willy@w.ods.org>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629142047.GA359@pcw.home.local>
References: <20030629130952.GA246@pcw.home.local> <20030629141102.GE27348@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629141102.GE27348@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 03:11:03PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sun, Jun 29, 2003 at 03:09:52PM +0200, Willy TARREAU wrote:
> > chroot("/var/empty") (read-only directory or file-system)
> > chdir("/")
> > listen(), accept(), fork(), whatever...
> > -> external code injection from a cracker :
> >    mount("none", "..", "ramfs")
> >    mkdir("../mydir")
> >    chdir("../mydir")
> >    the cracker now installs whatever he wants here.
> 
> That's a BS.  Same effect would be achieved by replacing ".." with ".".
> Or mounting on any existing subdirectory.

No, it works only with "..", and not with "." ! I don't know why, I believe
it's because the process is still attached to the old FS when mounting on ".".

> If attacker can mount of chroot - you've LOST.  Already.  End of story.

To me, it seems this is the *only* remaining case in an *empty* read-only
directory. The fact is that the attacker needs at least a mount point to mount
something. Not providing him one is efficient, but here he can only exploit
"..".

Please reconsider the question, Al, because I really think that with this, we
can get reliable jails for network daemons which don't need file access at all.

Cheers,
Willy

