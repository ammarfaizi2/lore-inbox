Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUH0IsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUH0IsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUH0IsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:48:09 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:3536 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S269020AbUH0Iqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:46:49 -0400
Date: Fri, 27 Aug 2004 10:46:47 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827084647.GA7545@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
	jamie@shareable.org, christophe@saout.de,
	vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
	spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
	reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261440550.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261149510.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261149510.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 11:55:07AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Aug 2004, Rik van Riel wrote:
> > 
> > So you'd have both a file and a directory that just happen
> > to have the same name ?  How would this work in the dcache?
> 
> There would be only one entry in the dcache. The lookup will select 
> whether it opens the file or the directory based on O_DIRECTORY (and 
> usage, of course - if it's in the middle of a path, it obviously needs to 
> be opened as a directory regardless).

hmm, that might be interesting for applications
like apache which allow to append arguments by
'building' a 'virtual' path ...

http://www.kernel.org/list.cgi/some/more/args

where the web server actually decides where the
script ends and the arguments start by checking
the filesystem ...

> That's not the problem. The problem from a dcache standpoint ends up being 
> when the file has a link, and you have two paths to the same sub-file 
> through two different ways:
> 
> 	.. create file 'x' with named stream 'y' ...
> 	ln x z
> 	ls -l x/y z/y	/* it's the same attribute!! */
> 
> but this is actually exactly the same thing that we already have with 
> mounts, ie it is equivalent (from a dentry standpoint) to
> 
> 	.. create directory 'x' with file 'y' ..
> 	mkdir z
> 	mount --bind x z
> 	ls -l x/y z/y	/* It's the same file!! */
> 
> so none of this is really anything "new" from a dcache standpoint.
> 
> Except for all the details, of course ;)

if the file is removed, but some attributes are
'locked' by access, will the 'other' attributes
remain visible or disappear ... leaving a partial
'view' of the contents? or did I get the idea
completely wrong?

TIA,
Herbert

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
