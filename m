Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUCWWI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUCWWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:08:56 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:44204 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262873AbUCWWIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:08:52 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Jonathan Sambrook <swsusp@hmmn.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040323214734.GD364@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <20040318193703.4c02f7f5.akpm@osdl.org>
	 <1079661410.15557.38.camel@calvin.wpcb.org.au>
	 <20040318200513.287ebcf0.akpm@osdl.org>
	 <1079664318.15559.41.camel@calvin.wpcb.org.au>
	 <20040321220050.GA14433@elf.ucw.cz>
	 <1079988938.2779.18.camel@calvin.wpcb.org.au>
	 <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org>
	 <20040323214734.GD364@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080076132.12965.18.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 24 Mar 2004 09:08:52 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-24 at 09:47, Pavel Machek wrote:
> Its 1000 lines. If it is not broken now, it will be broken in 2.8, and
> because it is in mainline, it will be up to linus to fix it.

Of the 1161 lines in ui.c, there are probably 200 lines of comments (the
header is 77 lines). Of what remains, I agree that there could be could
and should be some pruning before merging. Much of the debugging code
can be removed from the merged version and kept as a separate patch for
if/when its needed. I'm also of a mind to not include the original
text-mode 'nice display' and just use the Bootsplash support.

Of course there's also the point that you're assuming I'm going to
disappear into the wild blue yonder after it's merged. That assumption
has no basis from my perspective.

> Oh and it is enough confusing that it confuses me. Some messages end
> in dmesg, some do not. User feedback can be done with much less code,
> and also slightly less confusing for the user, see swsusp1. [We have
> to switch to another console, anyway; and printing dots is easy.]

As I said above, much of the code was from debugging and can be removed.
Nevertheless, the interface is not that confusing:

prepare_status: Set the title above the progress bar and optionally
reset the progress bar to 0. If the nice display is off, just print the
message.

update_status: Update the progress bar percentage.

print_nolog: Display a message without normally sticking it in the logs.
(Exception: if log everything is on). Used for the more verbose messages
(eg 1567/5624) so that detail can be seen without it cluttering the
logs.

print_log: Display a message and log it.

For print_nolog and print_log, we also take account of user definable
settings specifying what sections we want to see output from and how
much output we want, in deciding whether to print the message.

> Okay, we should probably make suspend more quiet, I can see users
> badly confused by those hdX: spinning down (etc) messages.

That's fine, but those messages aren't related to my code.

> Also, in your model, where do messages printk()-ed from drivers during
> suspend/resume end up? Corrupting screen? Lost from sight and only
> accessible from dmesg? I believe driver messages *are* important, and
> do not see how they could coexist with eye-candy.

They do go in the logs. An important exception though (which applies to
all implementations): messages displayed after the atomic copy is made
(while suspending) or before the kernel is copied back (resuming) as
lost because the printk buffer is overwritten,

Nigel.
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

