Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWDHHvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWDHHvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWDHHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:51:04 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:50875
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751395AbWDHHvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:51:03 -0400
Date: Sat, 8 Apr 2006 10:50:50 +0300
From: edwin@gurde.com
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
Message-ID: <20060408075050.GB5797@gurde.com>
References: <5X7nH-7n6-7@gated-at.bofh.it> <E1FRTVC-0000i5-PH@be1.lrz> <42865.86.125.51.175.1144436283.squirrel@www.gurde.com> <Pine.LNX.4.58.0604072149110.2496@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0604072149110.2496@be1.lrz>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 10:06:45PM +0200, Bodo Eggert wrote:
> On Fri, 7 Apr 2006 edwin@gurde.com wrote:
> 
> If apache is running a CGI script, it must pass the socket (bound to 
> remote:port,local:80, to the CGI at fd 2*. If your firewall is blocking
> this, your CGI scripts will stop working.
Hmm, an exception could be made for programs like apache.
The user would then create a rule that says that apache is allowed to pass on
file descriptors.
Or a rule could be created for the userspace part of fireflier that would auto-add the cgi-scripts 
to apache's group sid. Which IMHO would be the best, because the user will still have control on
what programs have access to the network. He can see that list at any time, and modify it, if not correct.
If we would simply allow file descriptors to be passed on, he wouldn't have that control.
(none of this is implemented yet)
> > running a program via NFS, and giving access for it to the network? why
> > would I want that?
> 
> Why not? E.g. you could set up a farm of redundand apache servers.
Ok, so the userspace part of fireflier will have to deal with nfs mounts as a special case.
It should store the rules in "server,path,executable hash" format, and do the inode lookup on startup,
or when the first packet arrives.
> > Aren't inodes stored on the disk?
> 
> At least Mostly, but is this a requirement?
Currently it is, until we implement path+hash rules for nfs mounts,etc.
What devices can I safely assume that the inodes won't change over boots/mounts?

Cheers,
Edwin
