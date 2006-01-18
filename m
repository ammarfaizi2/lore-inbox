Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWARFlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWARFlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWARFlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:41:39 -0500
Received: from mail.suse.de ([195.135.220.2]:42978 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030259AbWARFli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:41:38 -0500
Date: Wed, 18 Jan 2006 06:41:37 +0100
From: Nick Piggin <npiggin@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060118054136.GA27838@wotan.suse.de>
References: <20060116160420.GA21064@wotan.suse.de> <20060116212250.GD12159@atrey.karlin.mff.cuni.cz> <20060117113727.GB24083@wotan.suse.de> <20060117034601.6556322a.akpm@osdl.org> <20060117115945.GC24083@wotan.suse.de> <20060117140929.GA23497@wotan.suse.de> <20060117163235.GA18895@atrey.karlin.mff.cuni.cz> <20060117163622.GA20740@wotan.suse.de> <20060117222353.GA26770@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20060117222353.GA26770@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 17, 2006 at 11:23:53PM +0100, Jan Kara wrote:
> > On Tue, Jan 17, 2006 at 05:32:35PM +0100, Jan Kara wrote:
> > > > On Tue, Jan 17, 2006 at 12:59:45PM +0100, Nick Piggin wrote:
> > > > 
> > > > Maybe it is because people haven't been turning on their debugging options,
> > > > tsk tsk ;) It only oopses when DEBUG_SLAB and DEBUG_PAGEALLOC are both
> > > > enabled. And only then when the jbd patch is not reverted. Weird.
> > >   Hmm, that's really strange, maybe we have some use-after-free
> > > problem or so... I'll see what I can do :).
> > > 
> > 
> > Are you able to reproduce? If not I can test patches...
>   Hmm, I was not able to reproduce the problem even with those debug
> options set :(. As I'm looking into the code it seems that somebody
> managed to free the transaction but did not clear the
> j_checkpoint_transactions pointer. It's even stranger that it's during
> umount time when there should not be much processes playing with the JBD
> structures on that filesystem.
>   Attached is the patch that fixes two minor possible problems I've
> found. Neither of them should be causing your oops but one never knows
> :). Also turn on the JBD debugging in config. Maybe it spits something
> useful. If you still see the same oops, I'll create some debugging
> patch.

This patch does the trick. Survived several reboots now while without
the patch it has oopsed 100% of the time so far. Thanks!

I have also attached a full jbd debug output and oops for the vanilla
2.6.16-rc1 case, just in case that helps.

>   BTW: the oops during umount is after some activity on the filesystem
> or you just mount & umount?
> 

mount,unmount doesn't seem to trigger it, nor does a bit of filesystem
activity. I haven't tracked down exactly what *does* trigger it, but
booting then rebooting does it every time.

Nick

--tThc/1wpZn/ma/RB
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dmesg.bad.gz"
Content-Transfer-Encoding: base64

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
U1lA9gAA

--tThc/1wpZn/ma/RB--
