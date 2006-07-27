Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWG0GIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWG0GIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWG0GIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:08:54 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:33041 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932518AbWG0GIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:08:53 -0400
Date: Thu, 27 Jul 2006 08:06:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch/rfc] s390: get rid of own uid16 compat system calls
Message-ID: <20060727060626.GA9594@osiris.boeblingen.de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607270303.42959.arnd.bergmann@de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:03:42AM +0200, Arnd Bergmann wrote:
> On Monday 10 July 2006 10:51, Heiko Carstens wrote:
> > "Only" thing is that we unfortunately have different sizes for
> > __kernel_old_[uid|gid]_t (16 bit on s390, 32 on s390x). I was tempted to
> > change these just to find out that there are other users as well:
> > 
> > include/linux/ncp_fs.h:
> > ?#define NCP_IOC_GETMOUNTUID _IOW('n', 2, __kernel_old_uid_t)
> > include/linux/smb_fs.h:
> > ?#define SMB_IOC_GETMOUNTUID _IOR('u', 1, __kernel_old_uid_t)
> > 
> > So, this is no option. Would anybody know of something to get this work?
> > Or is this just a stupid idea?
> 
> Ok, I don't know exactly what you're talking about, but I have in the
> past tried to hack that area as well. It's probably a good idea to
> pick up my old patch and work from there, by making these two file systems
> understand all possible ways:

I dropped my initial patch and gave up on this. The idea of using
kernel/uid16.c for compat code seems to be... not very good :)
