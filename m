Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277346AbRJEKcC>; Fri, 5 Oct 2001 06:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277345AbRJEKbv>; Fri, 5 Oct 2001 06:31:51 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:10748 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S277344AbRJEKbm>; Fri, 5 Oct 2001 06:31:42 -0400
Date: Fri, 5 Oct 2001 11:31:46 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
Message-ID: <20011005113146.B3587@redhat.com>
In-Reply-To: <706340000.1002116485@gullevek.piwi.intern> <E15oqKN-00058k-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15oqKN-00058k-00@calista.inka.de>; from ecki@lina.inka.de on Wed, Oct 03, 2001 at 08:01:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 03, 2001 at 08:01:03PM +0200, Bernd Eckenfels wrote:
> 
> Do you had NFS Problems or do you had filesystem problems?
> 
> Because NFS interaction with Journaled Filesystems is/was an issue with
> those recent kernels, as far as i understand.

Should be fine with ext3 and XFS.  It's not a journaling problem as
much as NFS assuming a particular property of the filesystem.

Resierfs had a particular difficulty with NFS, mainly because the NFS
spec assumes that every file can be looked up by a 64-bit cookie which
doesn't change over reboots, and that's a hard invariant to deal with
when you've only got 32-bit inode numbers in the kernel and when your
filesystem is tree-structured so that the file metadata on disk can
move about.  The VFS has been extended a bit in more recent kernels to
allow Reiserfs to give NFS the hints it needs to get the file handles
right.

Cheers,
 Stephen
