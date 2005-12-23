Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVLWNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVLWNiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVLWNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:38:24 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:17673 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S1030423AbVLWNiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:38:23 -0500
From: Ron Peterson <rpeterso@MtHolyoke.edu>
Date: Fri, 23 Dec 2005 08:38:01 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Message-ID: <20051223133801.GA9321@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu> <1135293713.3685.9.camel@lade.trondhjem.org> <20051223013933.GB22949@mtholyoke.edu> <1135302325.3685.69.camel@lade.trondhjem.org> <20051223022126.GC22949@mtholyoke.edu> <1135327075.8167.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135327075.8167.6.camel@lade.trondhjem.org>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 09:37:55AM +0100, Trond Myklebust wrote:
> On Thu, 2005-12-22 at 21:21 -0500, Ron Peterson wrote:
> 
> > Why it doesn't work .. I dunno.  My current best guess is that the
> > manner in which the insecure_locks option in /etc/exports is applied to
> > directories isn't quite right.
> 
> insecure_locks has nothing at all to do with directories. It has to do
> with the NLM protocol, which is used by NFSv2/v3 to implement posix
> locks.
> Directory locking is an entirely separate matter, and is not part of the
> NFS protocol (the server will take care of locking the directory when it
> needs to modify it without any extra help from the client).
> 
> IOW: your problem here has nothing to do with insecure_locks, and
> everything to do with your setup. Please double-check that the gid
> mappings for the group 'kwc' in /etc/groups match on the client and
> server, and note that the default root squashing means that your root
> account will get mapped to the user with uid -2 and gid=-2

The gid's of the kmw group match on both sides.  The problem happens
whether root squashing is on or off.  Unless the execute bit for 'other'
is turned on for the parent directory, the file appears to be locked
when being accessed from the nfs client (tru64) side.

My theory may be wrong, but the problem still exists.

Best.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://pks.mtholyoke.edu:11371/pks/lookup?search=0xB6D365A1&op=vindex
