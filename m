Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEAOYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTEAOYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:24:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59365 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261311AbTEAOYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:24:01 -0400
Date: Thu, 01 May 2003 07:35:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Willy TARREAU <willy@w.ods.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel source tree splitting
Message-ID: <13900000.1051799746@[10.10.2.4]>
In-Reply-To: <20030501142041.GD308@pcw.home.local>
References: <200305010756_MC3-1-36E1-623@compuserve.com>
 <11850000.1051797996@[10.10.2.4]> <20030501142041.GD308@pcw.home.local>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Indeed. But whilst you're waiting, hardlink everything together, and 
>> patch the differences (patch knows how to break hardlinks). Make a 
>> script that cp -lR's the tree to another copy (normally takes < 1s), and
>> then remove the other arches. grep that.
> 
> I agree with Martin here, I always use hardlinks, and when I have too many
> kernel trees, I even recompact them by diff/rm/cp -l/patch to get as small
> differences as possible. You can have tens of kernels in less than 400 MB,
> and tools such as diff and grep are really fast because it's easy to keep
> several kernels in the cache.
> 
> The only danger is to modify several files at once with stupid operations
> such as "cat $file.help >> Documentation/Configure.help" which are
> sometimes included in some scripts. It would be cool to be able to lock
> the source, but I never found how (perhaps I should try chattr+i ?). And
> I don't know how to force vi and emacs to unlink before saving, so I have
> to be careful before certain operations. But all in all, it's extremely
> useful.

find -type f | xargs chmod ugo-w 

whenever you make a new copy seems to work pretty well to me. 
Then you use "dupvi" to edit the files, which is just a little wrapper that
breaks the link, and edits the file. 

For added paranoia, I suppose you could make your "main" views (eg the
unpatched ones) owned by another user. But I've never had a problem with
just chmod, and I have a lot of views ... 1689 all linked together ;-)

-r--r--r--  1689 fletch   fletch      18691 Nov 17 20:29 COPYING

Oh, and diff of views takes < 1s (diff understands hardlinks too, it seems).
Any SCM can kiss my ass ;-)

M.
