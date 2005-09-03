Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbVICFzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbVICFzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbVICFzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:55:10 -0400
Received: from smtp.istop.com ([66.11.167.126]:56246 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1161150AbVICFzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:55:08 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: GFS, what's remaining
Date: Sat, 3 Sep 2005 01:57:31 -0400
User-Agent: KMail/1.8
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050901132104.2d643ccd.akpm@osdl.org> <p73fysnqiej.fsf@verdi.suse.de>
In-Reply-To: <p73fysnqiej.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509030157.31581.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 17:17, Andi Kleen wrote:
> The only thing that should be probably resolved is a common API
> for at least the clustered lock manager. Having multiple
> incompatible user space APIs for that would be sad.

The only current users of dlms are cluster filesystems.  There are zero users 
of the userspace dlm api.  Therefore, the (g)dlm userspace interface actually 
has nothing to do with the needs of gfs.  It should be taken out the gfs 
patch and merged later, when or if user space applications emerge that need 
it.  Maybe in the meantime it will be possible to come up with a userspace 
dlm api that isn't completely repulsive.

Also, note that the only reason the two current dlms are in-kernel is because 
it supposedly cuts down on userspace-kernel communication with the cluster 
filesystems.  Then why should a userspace application bother with a an 
awkward interface to an in-kernel dlm?  This is obviously suboptimal.  Why 
not have a userspace dlm for userspace apps, if indeed there are any 
userspace apps that would need to use dlm-style synchronization instead of 
more typical socket-based synchronization, or Posix locking, which is already 
exposed via a standard api?

There is actually nothing wrong with having multiple, completely different 
dlms active at the same time.  There is no urgent need to merge them into the 
one true dlm.  It would be a lot better to let them evolve separately and 
pick the winner a year or two from now.  Just think of the dlm as part of the 
cfs until then.

What does have to be resolved is a common API for node management.  It is not 
just cluster filesystems and their lock managers that have to interface to 
node management.  Below the filesystem layer, cluster block devices and 
cluster volume management need to be coordinated by the same system, and 
above the filesystem layer, applications also need to be hooked into it.  
This work is, in a word, incomplete.

Regards,

Daniel
