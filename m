Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUA0PYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUA0PYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:24:39 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:39686 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264444AbUA0PYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:24:36 -0500
Date: Tue, 27 Jan 2004 23:23:46 +0800 (WST)
From: raven@themaw.net
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       LKML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH 2/2] vfsmount_lock / mnt_parent
In-Reply-To: <20040127141744.GA7357@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0401272315020.3101@raven.themaw.net>
References: <40159DC7.9080504@sun.com> <20040127141744.GA7357@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry I mised this thread but ...

On Tue, 27 Jan 2004, Maneesh Soni wrote:

> On Mon, Jan 26, 2004 at 11:11:31PM +0000, Mike Waychison wrote:
> > The attached patch ensures that we grab vfsmount_lock when grabbing a 
> > reference to mnt_parent in follow_up and follow_dotdot.
> > 
> > We also don't need to access ->mnt_parent in follow_mount and 
> > __follow_down to mntput because we already the parent pointer on the stack.
> > 
> > 
> 
> As pointed by Viro on IRC, there are other places where we access/use 
> mnt_parent without any protection. IIUC this needs either vfsmount_lock or the
> namespace sem for protection. I did audit such places and hope not missed
> anything else.
> 
> One such place is in autofs4's is_vfsmnt_tree_busy() routine. I hope Ian still 
> has the expire patch which corrects it. Didn't know why this patch never hit
> lkml.

The patch has never been posted seperately. It is part of a patch set for 
autofs4, to support the autofs 4.1.0+ daemon, that I sent to Andrew 
Morton. I was hoping that Jeremy would review them and they would make 
their way to Al but perhaps neither has had time to follow up.

I must add that Mike has pointed out that the vfsmount_lock, used by the 
patch is not exported and the patch does not change that.

Ian

