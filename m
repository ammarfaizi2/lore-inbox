Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUFUWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUFUWBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUFUWBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:01:03 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:32812 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266485AbUFUWBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:01:01 -0400
Date: Tue, 22 Jun 2004 00:12:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK and 'make distclean'
Message-ID: <20040621221244.GB2903@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <40D700A4.8040708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D700A4.8040708@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 11:37:08AM -0400, Jeff Garzik wrote:
> It appears we have a conflict between what BitKeeper thinks is a source 
> file, and what kbuild thinks is a source file:
> 
> 	[jgarzik@sata linux-2.6]$ bk -r co -Sq
> 	[jgarzik@sata linux-2.6]$ make distclean
> 	  CLEAN   scripts/package
> 	[jgarzik@sata linux-2.6]$ bk -r co -Sq
> 	[jgarzik@sata linux-2.6]$ make distclean
> 	  CLEAN   scripts/package

It happens because I used 'clean-rule' in the package makefile.
The problem is that I need to delete files at the root of the kernel src tree,
and usually kbuild add the $(obj)/ prefix.

So when we visit package/ the clean-rule is not empty and get executed.

I will fix tomorrow. Just need to add a simple existence check 
before assigning 'clean-rule'.


	Sam
