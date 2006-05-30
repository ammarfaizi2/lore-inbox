Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWE3SoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWE3SoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWE3SoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:44:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbWE3SoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:44:17 -0400
Date: Tue, 30 May 2006 11:44:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tomasz Torcz <zdzichu@irc.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel paging request at virtual address
 feededed (was: Re: Linux v2.6.17-rc5)
In-Reply-To: <20060528182342.GA9433@irc.pl>
Message-ID: <Pine.LNX.4.64.0605301132180.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org> <20060528182342.GA9433@irc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 May 2006, Tomasz Torcz wrote:
>
>   After 2 days and few hours uptime, during updatedb run I got:
> 
> BUG: unable to handle kernel paging request at virtual address feededed

Looks like one of the magic numbers ("0xfee1dead", "0xfeedbeef", 
0xfeedface"), but that's not it.

>  It never happened before. d_splice_alias in bt is very strange, as I don't
> think anything on my system uses splice(). It's too new, and my system is
> Slackware -current (which seems to return ENOSUPORTED even for old stuff
> like posix_fadvise()).

No, d_splice_alias() is a different kind of splicing: it splices a dentry 
entry into the alias list. Nothing to do with the new splice() system 
call, except that the naming comes from the same english word ("splice: to 
join two ropes by interweaving strands").

I don't see anything suspicious anywhere, and this doesn't ring a bell. 
It is probably a good idea to open a bugzilla entry on it, so that it 
doesn't get lost. And perhaps cc the reiserfs people (there's been a few 
reiserfs changes since 2.6.16, but none of them looks suspicious to me: 
however, maybe this makes somebody else go "Aaah!").

Try Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com> and 
Alexander Zarochentzev <zam@namesys.com>.

			Linus
