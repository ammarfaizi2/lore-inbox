Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUL3J67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUL3J67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUL3J67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:58:59 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:20624 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261604AbUL3J6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 04:58:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Ho ho ho - Linux v2.6.10
Date: Thu, 30 Dec 2004 10:58:54 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wichert Akkerman <wichert@wiggy.net>, hugang@soulinfo.com
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200412261445.09336.Rafal.Wysocki@fuw.edu.pl> <20041226193943.GE1661@elf.ucw.cz>
In-Reply-To: <20041226193943.GE1661@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412301058.55320.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 26 of December 2004 20:39, Pavel Machek wrote:
> Hi!
> 
> > > 2.6.10 broke resume for me: when I resume it immediately tries to
> > > suspend the machine again but gets stuck after suspending USB.
> > 
> > Usually, it resumes sucessfully for me, but sometimes it fails, like this 
(on 
> > an AMD64):
> > 
> >  swsusp: Image: 43552 Pages
> >  swsusp: Pagedir: 341 Pages
> > pmdisk: Reading pagedir (341 Pages)
> > Relocating 
> > 
pagedir ...........................................................................................................................0
> > 
> > Call Trace:<ffffffff8016de7e>{__alloc_pages+766} 
> > <ffffffff8016df21>{__get_free_pages+33}
> >        <ffffffff8056191c>{swsusp_read+1020} 
> > <ffffffff8015f711>{software_resume+33}
> >        <ffffffff8010c142>{init+162} <ffffffff8010f57b>{child_rip+8}
> >        <ffffffff8010c0a0>{init+0} <ffffffff8010f573>{child_rip+0}
> > 
> > out of memory
> 
> ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::g
> > PM: Resume from disk failed.
> 
> Can you try this one? It would be nice to have reproducible way to
> trigger this before trying to fix it, through.

It looks like growing the inode and/or dentry cache before suspend does the 
trick.  It seems that updatedb (again) is quite good for this purpose but 
it's not 100% "effective".

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
