Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWBWUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWBWUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWBWUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:43:26 -0500
Received: from kanga.kvack.org ([66.96.29.28]:61320 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751367AbWBWUnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:43:25 -0500
Date: Thu, 23 Feb 2006 15:38:26 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-ID: <20060223203826.GC30329@kvack.org>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain> <20060222175030.GB30556@lnx-holt.americas.sgi.com> <1140648776.1729.5.camel@localhost.localdomain> <20060222151223.5c9061fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222151223.5c9061fd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:12:23PM -0800, Andrew Morton wrote:
> It's not a terribly bad hack - it's just poor-man's hashing, and it's
> reasonably well-suited to the sorts of machines and workloads which we
> expect will hit this problem.

The dnotify/inotify wakeups are a problem, namely because the implementation 
is braindead: it makes the wrong part of the interface fast (setting up 
notify entries) at the expense of making the rest of the kernel slow (adding 
locks to read()/write()).  read() and write() are incredibly hot paths in 
the kernel and should be optimized at the expense of dnotify and inotify, 
which are uncommon operations.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
