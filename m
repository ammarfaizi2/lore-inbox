Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVANOc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVANOc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVANOc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:32:58 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:44173 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261991AbVANOcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:32:55 -0500
To: aia21@cam.ac.uk
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.60.0501141409500.18572@hermes-1.csi.cam.ac.uk>
	(message from Anton Altaparmakov on Fri, 14 Jan 2005 14:14:12 +0000
	(GMT))
Subject: Re: [PATCH 2/11] FUSE - core
References: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.60.0501141351130.18572@hermes-1.csi.cam.ac.uk>
 <E1CpS73-0001kC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0501141409500.18572@hermes-1.csi.cam.ac.uk>
Message-Id: <E1CpSV7-0002Ac-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 15:32:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I prefer the _NOFS regardless (and others will probably disagree) because 
> it also means that if a machine is seriously running out of memory the fs 
> will give up with -ENOMEM much more readily with _NOFS rather than 
> increasing the memory pressure even further.  As I said, others probably 
> disagree with me...

Then you are suggesting to add __GFP_NORETRY, to all my allocations.
That's may well be a valid argument, if we want to treat userspace
filesystems less critical, than other things.

Adding _NOFS in the case where no deadlock is possible makes things
worse not better, since you are limiting the allocation from
performing I/O.  It's clearly a losing situation.

Thanks,
Miklos
