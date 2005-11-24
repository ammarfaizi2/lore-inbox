Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVKXT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVKXT5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKXT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:57:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751393AbVKXT5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:57:31 -0500
Date: Thu, 24 Nov 2005 11:57:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: Andreas Ericsson <ae@op5.se>, Ed Tomlinson <tomlins@cam.org>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0511241154340.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
 <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org> <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Nov 2005, Junio C Hamano wrote:
> 
> Performance perceived by cloners is helped by
> 
>     $ mkdir -p .git/pack-cache
>     $ git-rev-list --objects --all | git-pack-objects .git/pack-cache/pack

That really doesn't work very well. I push to that tree often several 
times a day, and you'd have to re-do the cache each time.

So it would be much better if git-pack-objects would just always cache its 
output in .git/pack-cache - along with some logic to just get rid of old 
ones regularly.

Since git-pack-objects has to generate the pack _anyway_, it might as well 
save it away when it does - so that if you have lots of people doing 
clones or pulling, you'd only need to run it once for a particular set of 
objects, and you'd not have to do any extra (or unnecessary) maintenance.

		Linus
