Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFMUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFMUiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFMUfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:35:13 -0400
Received: from post-22.mail.nl.demon.net ([194.159.73.192]:13841 "EHLO
	post-22.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S261303AbVFMUa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:30:56 -0400
Date: Mon, 13 Jun 2005 22:31:06 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050613203106.GA19007@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <f192987705061303383f77c10c@mail.gmail.com> <1118669746.13260.20.camel@localhost.localdomain> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118690448.13770.12.camel@localhost.localdomain>
Organization: M38c
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 08:20:53PM +0100, Alan Cox wrote:
> On Llu, 2005-06-13 at 18:20, Alexey Zaytsev wrote:
> > Yes, that's how it works, but if I want ext or reiser or whatever to
> > have NLS, I'll have to make them support it (btw, if I do so, wont it
> > be rejected?). I want to move the NLS one level upper so the
> > filesystem imlementations won't have to worry about it any more. I
> > don't have much kernel experience, and none in the fs area, so I can't
> > explain it any better, but hope you get the idea.
> 
> An ext3fs is always utf-8. People might have chosen to put other
> encodings on it but thats "not our fault" ;)
> 
> There are some good technical reasons too
> 
> Encodings don't map 1:1 - two names may cease to be unique
> 
> Encodings vary in length - image a file name that is longer than the
> allowed maximum on your system with your encoding choice - that could
> occur with KOI8-R to UTF-8 I believe
> 
> That said it ought to be possible to use the stackable fs work (FUSE
> etc) to write a layer you can mount over any fs that does NLS
> translation.

Or just make a symbolic linked shadow FS with translated filenames
(UNTESTED):

cd /tmp
cp -src /mnt/problem_dir .
find problem_dir -exec bash -c "mv \'{}\' \'$(echo {} | iconv -f KOI8-R -t UTF-8)\'" \;

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
