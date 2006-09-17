Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWIQBax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWIQBax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWIQBaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:30:52 -0400
Received: from cs.columbia.edu ([128.59.16.20]:10638 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S964894AbWIQBav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:30:51 -0400
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
From: Shaya Potter <spotter@cs.columbia.edu>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <20060916221341.GB28659@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014251.GF5788@fsl.cs.sunysb.edu>
	 <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
	 <20060904092534.GA19836@filer.fsl.cs.sunysb.edu>
	 <Pine.LNX.4.61.0609041239390.17115@yvahk01.tjqt.qr>
	 <20060916221341.GB28659@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 21:28:55 -0400
Message-Id: <1158456535.17898.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 18:13 -0400, Josef Sipek wrote:
> On Mon, Sep 04, 2006 at 12:41:58PM +0200, Jan Engelhardt wrote:
> > 
> > >> Is BUG the right thing, what do others think? (Using WARN, and set err to
> > >> something useful?)
> > > 
> > >Well, it is definitely a condition which Unionfs doesn't expect - if it
> > >doesn't know about the type, how could it copy it up?
> > 
> > Other filesystems don't seem to BUG either (at least I have not run into 
> > that yet) when - for whatever reasons - the statdata of a dentry is 
> > fubared. `ls`  just displays it then, like
> > 
> >  ?-w---Sr-T 1 root root 4294967295 date fubared_file
> 
> I was thinking about this, and the difference between "other filesystems"
> and unionfs in this case is that the example above is just stat. During
> copyup, unionfs has to copy the file to another filesystem. How is it
> supposed to do that when it doesn't understand what the file is?
> 
> Sure, when unionfs does stat, fubared statdata is fine, but during
> copyup...bad things could potentially happen.
> 
> Any suggestions how to copyup an unknown file type?

copyup is only required if a file is going to be modified.  refuse to
modify (or perhaps even open for write) an unknown file?  i.e. calling
BUG() is bad when it can be cleanly handled much earlier in the chain.

