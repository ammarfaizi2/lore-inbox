Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCFIPr>; Wed, 6 Mar 2002 03:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCFIPh>; Wed, 6 Mar 2002 03:15:37 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:58102 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293344AbSCFIP1>;
	Wed, 6 Mar 2002 03:15:27 -0500
Date: Wed, 6 Mar 2002 01:15:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Michael Cheung <vividy@justware.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: mount -o remount,ro cause error "device is busy"
Message-ID: <20020306011519.C963@lynx.adilger.int>
Mail-Followup-To: Michael Cheung <vividy@justware.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020306161900.C897.VIVIDY@justware.co.jp> <20020306074908.GA342@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020306074908.GA342@matchmail.com>; from mfedyk@matchmail.com on Tue, Mar 05, 2002 at 11:49:08PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 05, 2002  23:49 -0800, Mike Fedyk wrote:
> On Wed, Mar 06, 2002 at 04:40:10PM +0900, Michael Cheung wrote:
> > 	I have upgraded my kernel to version 2.4.
> > And i have tested 2.4.16 and 2.4.18. Both of these
> > two version have the same problem when system reboot.
> > "/: device is busy";
> > in shutdown script:
> > umount -a
> > mount -n -o ro,remount /
> > these two line result error: device is busy.
> > 
> 
> We need more info about your config.  Do you have any patches in this
> kernel?  What modules have been loaded?  Highmem?  x86?  drive controller?
> drive? ram size? lspci output, etc...

Please don't send that.  It clearly appears to be a user problem.
Order of operations, as I read in the original email:
1) "/" and "/usr" are busy
2) shut down to single user mode
3) "/" still busy
4) "/usr" can be unmounted
5) didn't check that root can be remounted after umounting "/usr"

Clearly, some program is keeping "/usr" busy (which is keeping "/" busy)
before the change to single user mode.  Just a bit of "lsof" needed to
find such things.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

