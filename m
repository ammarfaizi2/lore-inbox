Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVKJTdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKJTdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVKJTdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:33:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbVKJTdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:33:12 -0500
Date: Thu, 10 Nov 2005 11:32:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
In-Reply-To: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Nov 2005, Junio C Hamano wrote:
> 
> Yeah, the original proposal (in TODO list) explicitly stated why
> I chose lost-found instead of lost+found back then, and somebody
> on the list (could have been Pasky but I may be mistaken) said
> not to worry.  In any case, if we go the route Daniel suggests,
> we would not be storing anything on the filesystem ourselves so
> this would be a non-issue.

I don't know how many people do this, but with the current kernel sources, 
"git-fsck-cache --full" takes about a minute on a reasonable fast machine 
with everything in cache (ie no real disk activity to speak of)

I personally think that's fine, since I repack my trees every once in a 
while, and almost never run a "--full" check, I only do incrementals 
(which are basically free). And I suspect that I run fsck a lot more than 
anybody else does.

But the point is, that if you actually run fsck every time you want to 
visualize your pending commits, you're going to feel the pain. 

I think having some kind of lost+found so that you don't have to re-run 
fsck just because you decided to look at them some other way (use "git 
log" instead of "gitk" or whatever) makes a lot of sense. But yes, it 
shouldn't really be called "lost+found" due to some rather serious 
confusion that can cause.

		Linus
