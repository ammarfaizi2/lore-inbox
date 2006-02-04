Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWBDCRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWBDCRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946245AbWBDCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:17:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751546AbWBDCRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:17:12 -0500
Date: Fri, 3 Feb 2006 18:16:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
cc: Ryan Anderson <ryan@michonline.com>, Larry.Finger@lwfinger.net,
       ornati@fastwebnet.it, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
In-Reply-To: <20060204013522.3656f4f6.diegocg@gmail.com>
Message-ID: <Pine.LNX.4.64.0602031809010.3969@g5.osdl.org>
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
 <43E3A001.7080309@lwfinger.net> <20060203205716.7ed38386@localhost>
 <43E3BF5A.3040305@lwfinger.net> <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
 <43E3C703.20501@lwfinger.net> <20060203235002.GA5580@mythryan2.michonline.com>
 <20060204013522.3656f4f6.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Feb 2006, Diego Calleja wrote:
> 
> diego@estel ~/kernel/linux-2.6 # git repack -a -d
> Packing 185104 objects
> Pack pack-b87f4fd87979fe91a0141c7037b3dfbddd0a8c0a created.
> error: wrong index file size
> diego@estel ~/kernel/linux-2.6 #
> 
> Is this expected? :/ (git 1.1.5)

Absolutely not. 

You have a corrupted pack somewhere. I suspect that you may have 
interrupted a "rsync" transfer, and have a partial pack-file (or, in this 
case, the index file _descibing_ that pack-file) in your repository as a 
result.

Did you perhaps do a ^C in frustration when you first did the rsync: pull, 
and noticed that it was going to pull the whole big new pack-file?

It's kind of as if you had copied a CVS archive by doing a "cp -r" on 
CVSROOT, and interrupted it half-way. 

You can run

	git fsck-objects --full

which will do a full fsck and warn about anything it finds.

(and any pack it complains about you should just remove: if it turns out 
that the pack actually contained some data you need, at worst you can then 
use "rsync" to repopulate the .git object database, and while some object 
damage can be repaired, it's simply not _worth_ repairing it).

		Linus
