Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWGNNqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWGNNqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWGNNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 09:46:31 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:47756 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030449AbWGNNqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 09:46:30 -0400
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
From: Arjan van de Ven <arjan@linux.intel.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <m3u05kqvla.fsf@telia.com>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <m3sllxtfbf.fsf@telia.com> <1151000451.3120.56.camel@laptopd505.fenrus.org>
	 <m3u05kqvla.fsf@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Jul 2006 15:46:10 +0200
Message-Id: <1152884770.3159.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 13:22 +0200, Peter Osterlund wrote:
> > and what locking prevents this? And via multiple opens?
> 
> You are right that my reasoning was incorrect. If someone is doing
> "pktsetup ; pktsetup -d" quickly in a loop while someone else is
> trying to open the device, one thread could be at the start of
> pkt_open() at the same time as another thread is in pkt_new_dev().
> 
> However, I added a 5s delay in pkt_open() to enlarge the race window.
> I still couldn't make the driver lock up though. The explanation is
> that pkt_new_dev() calls blkdev_get() with the CD device (eg /dev/hdc)
> as bdev parameter, while do_open() locks the bd_mutex for the pktcdvd
> device (eg /dev/pktcdvd/0).
> 
> Do you still think this could deadlock? If not, how should the code be
> annotated to make this warning go away?

unless we KNOW it won't deadlock (eg we have a "this cannot deadlock
BECAUSE of X, Y and Z") I don't think annotations are the right idea. In
addition, the "how to annotate" really depends on what X, Y and Z
are....

