Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTBUT7E>; Fri, 21 Feb 2003 14:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267667AbTBUT7E>; Fri, 21 Feb 2003 14:59:04 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:5043 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S267659AbTBUT7D>; Fri, 21 Feb 2003 14:59:03 -0500
Date: Fri, 21 Feb 2003 15:04:40 -0500
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, mason@suse.com, sam@vilain.net,
       vs@namesys.com, nikita@namesys.com, trond.myklebust@fys.uio.no,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030221200440.GA23699@delft.aura.cs.cmu.edu>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Andrew Morton <akpm@digeo.com>, mason@suse.com, sam@vilain.net,
	vs@namesys.com, nikita@namesys.com, trond.myklebust@fys.uio.no,
	jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221220341.A9325@namesys.com>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 10:03:41PM +0300, Oleg Drokin wrote:
> Ok, here is my simple attempt. I just took a patch from early 2.5
> days by jaharkes@cs.cmu.edu ;)

Nice to see that it is being considered for a backport to 2.4, that
would allow me to get rid of the lock around the call to iget4.

Why didn't you take the final version that was sent to Linus? It was
against 2.5.14, but should be pretty close for 2.4.x. You can find
it at http://delft.aura.cs.cmu.edu/icreate/, both broken up in small
steps, and as one big patch.

As far as I know, the only change/improvement that went into 2.5 at a
later time was the ilookup code.

> Coda changes are not tested, but look correct.

Those Coda changes are not correct as we really need to use iget4 (or
in the new code, iget5_locked). That patch looks like it won't even
compile, coda_inocmp is simply removed while it is still used by the two
calls to iget4 that you didn't replace with iget5_locked. Let alone
adding the inode initializer. I also don't know why you are adding an
unused local variable to coda_replace_fid.

Jan

