Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCNSio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCNSio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCNShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:37:21 -0500
Received: from mail1.azairenet.com ([66.92.223.4]:19028 "EHLO
	dsl092-223-002.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S261663AbVCNSgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:36:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: fsck error on flashcard with ext2 filesystem
Date: Mon, 14 Mar 2005 10:36:11 -0800
Message-ID: <C8E1D942CB394746BE5CFEB7D97610E741EA71@bart.corp.azairenet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fsck error on flashcard with ext2 filesystem
Thread-Index: AcUofFFQZCJFh3VRT+WpMsxxeiZLLAAR9qBg
From: "Santosh Gupta" <Santosh.Gupta@AzaireNet.com>
To: "Jan Kara" <jack@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,
	Please see comments inline.


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

<santosh>
Its NOT a vanilla kernel. I patched it with some local ppp and crypto patch, 
turned on couple of kernel options and nothing else.
The same patched kernel works fine (as described earlier in mail) on a 
normal Redhat 7.2 box.
</santosh>

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
