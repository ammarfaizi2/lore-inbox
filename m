Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWEMHYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWEMHYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 03:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEMHYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 03:24:34 -0400
Received: from smtpout.mac.com ([17.250.248.174]:62400 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932359AbWEMHYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 03:24:34 -0400
In-Reply-To: <200605121421.00044.rob@landley.net>
References: <200605121421.00044.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F68E5CEA-AB95-4E1C-9923-0882394AE16E@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Which process context does /sbin/hotplug run in?
Date: Sat, 13 May 2006 03:24:17 -0400
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 2006, at 14:20, Rob Landley wrote:
> Anybody know this one?  Now that filesystem namespaces are per- 
> process, and  move/bind mounts let us have cycles in our trees,

Actually; it doesn't.  Your example below looks like this:
> mount -t tmpfs /tmp /tmp
> cd /tmp
> mkdir sub
> mount --bind sub /var
> cd /var
> mkdir sub2
> mount --move /tmp sub2

/
   /var
     /var/sub
     /var/sub2
       /var/sub2/sub
       /var/sub2/sub2

The recursion ends there.  Basically with the first bind mount you  
attach the same instance of tmpfs to /tmp and /var, then you move the  
tmpfs from /tmp to the "/sub2" directory in the "/var" tmpfs  
_mountpoint_.  It's kind of confusing behavior; but the directory  
tree and the mount tree are basically kind of separate entities in a  
sense.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


