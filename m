Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWD2Pa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWD2Pa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 11:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWD2Pa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 11:30:57 -0400
Received: from mx2.rowland.org ([192.131.102.7]:57869 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750743AbWD2Pa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 11:30:57 -0400
Date: Sat, 29 Apr 2006 11:30:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>, <ashok.raj@intel.com>,
       <herbert@13thfloor.at>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>, <xfs-masters@oss.sgi.com>
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
In-Reply-To: <1146267809.7063.141.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0604291126001.31700-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, Chandra Seetharaman wrote:

> - if we are ok with a loss of a kbyte or two, 2.6.17 is fine as is 
>   (with my incorrect patches in).
> - if we want to save that memory, we can revert the two patches and fix
>   xfs to make the register calls only when hotplug cpu is defined. This
>   change is also minimal. It is a step in the right direction.
> 
> Only downside i can see in reverting my patch is that if there is any
> other modules that are doing the same as what xfs was doing, we might
> trip in a similar oops.

Once register_cpu_notifier is placed in an init section, everything should
be okay.  If some other module does _exactly_ what xfs did, it won't oops
-- instead the module will get an unresolved symbol error whenever someone
tries to insmod it, because the register_cpu_notifier symbol won't be
defined.  I think this is an appropriate kind of failure mode.

However, it wouldn't hurt to add some comments to the definition and 
declaration of register_cpu_notifier, explaining the circumstances in 
which it should be used.

Alan Stern

