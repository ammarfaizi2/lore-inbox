Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVCNJ6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVCNJ6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCNJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:58:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63722 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262096AbVCNJ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:58:07 -0500
Date: Mon, 14 Mar 2005 10:58:06 +0100
From: Jan Kara <jack@suse.cz>
To: Santosh Gupta <Santosh.Gupta@AzaireNet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck error on flashcard with ext2 filesystem
Message-ID: <20050314095806.GA17005@atrey.karlin.mff.cuni.cz>
References: <C8E1D942CB394746BE5CFEB7D97610E741EA6F@bart.corp.azairenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8E1D942CB394746BE5CFEB7D97610E741EA6F@bart.corp.azairenet.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> 	Although "sync" doesnt seem to make any difference to fsck output, 
> "blockdev --flushbufs" fixes the issue. 
> 
> Still wondering why the flushing of buffer behavior is different on a 
> system with normal harddisk (Redhat 7.2 with 2.4.26 kernel ) as compared
>  to a system with flashcard (CoreLinux with 2.4.26 kernel) although the 
> system parameters/daemons are the same. I dont have to do sync or 
> blockdev --flushbufs on standard system. Any ideas?
  Hmm, are the kernels really vanilla kernels without any patches?
Anyway the problem was that on the system with flashcard old data were
still kept in the cache for userspace (userspace uses cache independent from
the one filesystem uses), so it could be anything starting by different
amount of memory and ending at a different timing/command sequence
whatever...

> I was using fsck with "-n" option which doesnt executes the command, just
> shows what would be done. I thought it would be harmless.
  Ok, that won't harm the filesystem but you can still see errors which
are not on the filesystem (because of the cache issues).

> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz]
> Sent: Friday, March 11, 2005 6:37 AM
> To: Santosh Gupta
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: fsck error on flashcard with ext2 filesystem
> 
> 
>   Hello,
> 
>   just a reminder for the next time - please keep the lines length under 80
> characters.
> 
> > Detailed Description
> > -----------------------------
> > I am using Core Linux system on flashcard. Its another minimal linux
> > distribution. Root filesystem is cramfs and a rw partition on flash is
> > ext2. The system is always shutdown properly and initial fsck upon
> > bootup shows no error. But if I delete a file on flash card and run
> > fsck, it gives error in fsck. On umount and mounting again (or
> > reboot), fsck shows no problem. Issuing "sync" command doesnt make any
> > difference.
> > Why is the disk not getting updated with filesystem metadata even
> > after I wait for so long?
>   Hmm, it may be a cache aliasing issue (anyway doing fsck on a mounted
> filesystem is asking for a trouble and basically nobody promisses any
> result). But you may try doing something like:
>   sync; blockdev --flushbufs
> 
> before a fsck.
> 

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
