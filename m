Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWIPWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWIPWOE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWIPWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:14:04 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:197 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964785AbWIPWOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:14:02 -0400
Date: Sat, 16 Sep 2006 18:13:41 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
Message-ID: <20060916221341.GB28659@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014251.GF5788@fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr> <20060904092534.GA19836@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609041239390.17115@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609041239390.17115@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:41:58PM +0200, Jan Engelhardt wrote:
> 
> >> Is BUG the right thing, what do others think? (Using WARN, and set err to
> >> something useful?)
> > 
> >Well, it is definitely a condition which Unionfs doesn't expect - if it
> >doesn't know about the type, how could it copy it up?
> 
> Other filesystems don't seem to BUG either (at least I have not run into 
> that yet) when - for whatever reasons - the statdata of a dentry is 
> fubared. `ls`  just displays it then, like
> 
>  ?-w---Sr-T 1 root root 4294967295 date fubared_file

I was thinking about this, and the difference between "other filesystems"
and unionfs in this case is that the example above is just stat. During
copyup, unionfs has to copy the file to another filesystem. How is it
supposed to do that when it doesn't understand what the file is?

Sure, when unionfs does stat, fubared statdata is fine, but during
copyup...bad things could potentially happen.

Any suggestions how to copyup an unknown file type?

Josef 'Jeff' Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
