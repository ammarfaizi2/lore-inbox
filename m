Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUIPWdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUIPWdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPWdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:33:00 -0400
Received: from hera.kernel.org ([63.209.29.2]:51609 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268179AbUIPWas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:30:48 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: persistent ptys
Date: Thu, 16 Sep 2004 22:30:40 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cid46g$t0e$1@terminus.zytor.com>
References: <4139F3FA.1070107@coppice.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1095373841 29711 127.0.0.1 (16 Sep 2004 22:30:40 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 16 Sep 2004 22:30:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4139F3FA.1070107@coppice.org>
By author:	Steve Underwood <steveu@coppice.org>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> It seems BSD style ptys are on the way out, and most systems will soon 
> have just Unix98 style ptys. This makes me want to move something to 
> Unix98 ptys, but I'm not sure of the appropriate way. The issue is that 
> things like HylaFAX expect to work with well known, persistent, names 
> for modem ports. A 100% soft modem in user space can easily provide that 
> with BSD ptys. With Unix98 ptys it is not so obvious what to do. Most 
> commercial soft modems don't have this issue, as they are part kernel 
> space/part user space designs. Obviously creating a link to a 
> dynamically generated pty with a well known name, and various other 
> things could be done. However, I assume other people have had to do 
> similar persistent pty things, and there is a well defined common 
> practice for it. Can anyone tell me what it is? :-\
> 

Two options: either continue to use BSD ptys (the kinds of stuff you
describe above is actually the one case where BSD ptys is a better
choice than Unix98 ptys) *or* create symlinks -- or if that doesn't
work for you, device nodes -- dynamically.

I.e. have a program which opens /dev/ptmx, gets a slave pty with a
specific ptsname(), then does a symlink() into a suitable directory.
The symlink is your persistent name.

	-hpa

