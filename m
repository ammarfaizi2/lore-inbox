Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUHWNaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUHWNaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUHWNaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:30:19 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:43392 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264261AbUHWNaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:30:12 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 23 Aug 2004 09:30:00 -0400
To: Shriram R <shriram1976@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Effect of deleting executables of running programs
Message-ID: <20040823133000.GA4395@ncsu.edu>
References: <20040818181646.28610.qmail@web11412.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818181646.28610.qmail@web11412.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:16:46AM -0700, Shriram R wrote:
> a) I always thought that once a job is running, the
> executable is entirely loaded into memory and the
> abcd.out file is no longer needed.
> If so, then why does the a running job crash on
> deleting abcd.out ?  

No, programs sections are paged in as needed, so the
parts that are not running may not be in memory.

That said, the Unix way of dealing with files is by
reference counting.  This means that you can open a
file and delete it, and it is still kept around on
the disk until you close it (running a program counts
as having its file open).  So you are susposed to be
able to delete a program and running instances will not
be affected.

Unfortunatly, as you have discovered, NFS is kinda
sorta almost like a Unix file system, but not really.
You can NOT reliably access deleted files over NFS.
This is the root of what is causing your bus errors.

> b) To what extent can I trust that the rest of the 6-7
> jobs that are running have not been affected by this
> deletion of "abcd.out" ?

They are probably OK.

Thanks,

Jim
