Return-Path: <linux-kernel-owner+w=401wt.eu-S932441AbXAGI7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbXAGI7T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbXAGI7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:59:19 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33012 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441AbXAGI7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:59:17 -0500
Message-ID: <45A0B63E.2020803@zytor.com>
Date: Sun, 07 Jan 2007 00:58:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
References: <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu>
In-Reply-To: <20070107085526.GR24090@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> 
> At work, we had the same problem on a file server with ext3. We use rsync
> to make backups to a local IDE disk, and we noticed that getdents() took
> about the same time as Peter reports (0.2 to 2 seconds), especially in
> maildir directories. We tried many things to fix it with no result,
> including enabling dirindexes. Finally, we made a full backup, and switched
> over to XFS and the problem totally disappeared. So it seems that the
> filesystem matters a lot here when there are lots of entries in a
> directory, and that ext3 is not suitable for usages with thousands
> of entries in directories with millions of files on disk. I'm not
> certain it would be that easy to try other filesystems on kernel.org
> though :-/
> 

Changing filesystems would mean about a week of downtime for a server. 
It's painful, but it's doable; however, if we get a traffic spike during 
that time it'll hurt like hell.

However, if there is credible reasons to believe XFS will help, I'd be 
inclined to try it out.

	-hpa
