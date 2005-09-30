Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVI3MHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVI3MHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVI3MHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:07:43 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:53091 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030248AbVI3MHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:07:43 -0400
Date: Fri, 30 Sep 2005 14:07:39 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
Message-ID: <20050930120739.GB9328@harddisk-recovery.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433D1E5D.20303@pobox.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 07:15:41AM -0400, Jeff Garzik wrote:
> >automatically.  Running the following one-liner every once in a
> >while would sync your set of tags with Linus:
> >
> >git fetch origin `git-ls-remote --tags origin | sed -ne 
> >'s|^.*refs/tags/|tag |p'`
> 
> that's way too long and convoluted to deal with.  Once the 'git fetch 
> --tags' changes make it into the official repository (are they there 
> already?), I'll remove all the remaining direct references to running rsync.

FYI, the rsync command to get the tags blows away .git/branches/origin,
so on the next "git pull", git will tell you "Where do you want to
fetch from today?".

In the mean time, better make it two separate rsync commands (sorry for
the long lines):

rsync -a --delete --verbose --stats --progress \
  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/tags/ \
  .git/tags/

rsync -a --delete --verbose --stats --progress \
  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/heads/ \
  .git/heads/


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
