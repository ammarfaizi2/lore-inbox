Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUFXWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUFXWRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUFXWPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:15:49 -0400
Received: from gprs214-211.eurotel.cz ([160.218.214.211]:56449 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265828AbUFXWDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:03:34 -0400
Date: Fri, 25 Jun 2004 00:03:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan <alan@clueserver.org>
Cc: "Fao, Sean" <Sean.Fao@dynextechnologies.com>, linux-kernel@vger.kernel.org,
       Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040624220318.GE20649@elf.ucw.cz>
References: <20040624213041.GA20649@elf.ucw.cz> <Pine.LNX.4.44.0406241347560.18047-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406241347560.18047-100000@www.fnordora.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On one school server, theres 10MB quota. (Okay, its admins are
> > BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
> > its installed as default!), and immediately fills his/her quota with
> > cache files, leading to failed login next time (gnome just will not
> > start if it can't write to ~).
> > 
> > Imagine mozilla automatically marking cache files "elastic".
> > 
> > That would solve the problem -- mozilla caches would go away when disk
> > space was demanded, still mozilla's on-disk caching would be effective
> > when there is enough disk space.
> 
> How does Mozilla (or any process) react when its files are deleted from 
> under it?  Would the file remain until all the open processes close the 
> file or would it just "disappear"? 

Of course, if mozilla marked them "elastic" it should better be
prepared for they disappearance. I'd disappear them with simple
unlink(), so they'd physically survive as long as someone held them
open.

>  Would it delete entire directories or 
> just some of the files?  How does it choose?  (First up against the delete 
> when the drive space fills...)

Probably just some of the files... Or you could delete directory, too,
if it was marked "elastic". What to delete first... probably file with
oldest access time? Or random file, with chance of being selected
proportional to file size?

I'm not implementing it, I'm just arguing that it is usefull.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
