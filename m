Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTEAOL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEAOL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:11:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29456 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261288AbTEAOL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:11:58 -0400
Date: Thu, 1 May 2003 16:20:41 +0200
From: Willy TARREAU <willy@w.ods.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel source tree splitting
Message-ID: <20030501142041.GD308@pcw.home.local>
References: <200305010756_MC3-1-36E1-623@compuserve.com> <11850000.1051797996@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11850000.1051797996@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 07:06:37AM -0700, Martin J. Bligh wrote:
 
> Indeed. But whilst you're waiting, hardlink everything together, and 
> patch the differences (patch knows how to break hardlinks). Make a 
> script that cp -lR's the tree to another copy (normally takes < 1s), and
> then remove the other arches. grep that.

I agree with Martin here, I always use hardlinks, and when I have too many
kernel trees, I even recompact them by diff/rm/cp -l/patch to get as small
differences as possible. You can have tens of kernels in less than 400 MB,
and tools such as diff and grep are really fast because it's easy to keep
several kernels in the cache.

The only danger is to modify several files at once with stupid operations such
as "cat $file.help >> Documentation/Configure.help" which are sometimes
included in some scripts. It would be cool to be able to lock the source, but
I never found how (perhaps I should try chattr+i ?). And I don't know how to
force vi and emacs to unlink before saving, so I have to be careful before
certain operations. But all in all, it's extremely useful.

Cheers,
Willy

