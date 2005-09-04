Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVIDHZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVIDHZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIDHZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 03:25:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbVIDHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 03:25:42 -0400
Date: Sun, 4 Sep 2005 00:23:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: phillips@istop.com, Joel.Becker@oracle.com, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050904002343.079daa85.akpm@osdl.org>
In-Reply-To: <20050904061045.GI21228@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904061045.GI21228@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh <mark.fasheh@oracle.com> wrote:
>
> On Sat, Sep 03, 2005 at 09:46:53PM -0700, Andrew Morton wrote:
> > Actually I think it's rather sick.  Taking O_NONBLOCK and making it a
> > lock-manager trylock because they're kinda-sorta-similar-sounding?  Spare
> > me.  O_NONBLOCK means "open this file in nonblocking mode", not "attempt to
> > acquire a clustered filesystem lock".  Not even close.
>
> What would be an acceptable replacement? I admit that O_NONBLOCK -> trylock
> is a bit unfortunate, but really it just needs a bit to express that -
> nobody over here cares what it's called.

The whole idea of reinterpreting file operations to mean something utterly
different just seems inappropriate to me.

You get a lot of goodies when using a filesystem - the ability for
unrelated processes to look things up, resource release on exit(), etc.  If
those features are valuable in the ocfs2 context then fine.  But I'd have
thought that it would be saner and more extensible to add new syscalls
(perhaps taking fd's) rather than overloading the open() mode in this
manner.
