Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbTF2ONe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTF2ONe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:13:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265678AbTF2ONH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:13:07 -0400
Date: Sun, 29 Jun 2003 15:27:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629142725.GF27348@parcelfarce.linux.theplanet.co.uk>
References: <20030629130952.GA246@pcw.home.local> <20030629141102.GE27348@parcelfarce.linux.theplanet.co.uk> <20030629142047.GA359@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629142047.GA359@pcw.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 04:20:47PM +0200, Willy TARREAU wrote:
> No, it works only with "..", and not with "." ! I don't know why, I believe
> it's because the process is still attached to the old FS when mounting on ".".

So?  chdir around and you'll get to the covering directory.
 
> > If attacker can mount of chroot - you've LOST.  Already.  End of story.
> 
> To me, it seems this is the *only* remaining case in an *empty* read-only
> directory. The fact is that the attacker needs at least a mount point to mount
> something. Not providing him one is efficient, but here he can only exploit
> "..".
>
> Please reconsider the question, Al, because I really think that with this, we
> can get reliable jails for network daemons which don't need file access at all.

Sigh...  We _can't_ do that via chroot().  Please, stop fooling yourself -
if attacker gets control over root process, the fight is over.  In particular,
attacker can chmod your read-only directory and/or remount the thing.
