Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbTILIXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTILIXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:23:43 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:62963 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261274AbTILIXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:23:42 -0400
Subject: Re: [PATCH] sysfs & dput.
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF1FA34869.DEA57E52-ONC1256D9F.002D8F32-C1256D9F.002E0C55@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 12 Sep 2003 10:22:58 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 12/09/2003 10:23:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pat,

> > there is another, small bug in sysfs. In sysfs_create_bin_file
> > dentry gets assigned the error value of the call to sysfs_create
> > if the call failed. The subsequent call to dput will crash. The
> > solution is to remove the assignment of the error to dentry.
>
> Thanks for the catch; Andrew Morton also posted a patch yesterday.
> However, your patch drops the error value, and his adds another variable.
> The patch below should be equivalent (and fixes the same problem for
> directories, too).
>
> Please test it, if you get a chance.

My patch fixes sysfs_create_bin_file which returns error and not the dentry,
the assignment to dentry is a dead assignment. But anyway I indeed missed
the second place where the dput is problematic. What I don't like about
the new patch is that dentry is accessed AFTER the dput. The chances are
slim but the dentry could have been deleted and if the dput drops the
reference count to zero you access an already freed structure.

blue skies,
   Martin


