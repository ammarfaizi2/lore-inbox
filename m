Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVGSTMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVGSTMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVGSTMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:12:21 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:4117 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261856AbVGSTMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:12:20 -0400
Message-ID: <42DD50FC.9090004@tu-harburg.de>
Date: Tue, 19 Jul 2005 21:14:04 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org>
In-Reply-To: <20050719183206.GA23253@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> So the size you want to reflect is n*<stack-depth> i take it?  Where
> in this case n is 20?
> 
> So you can seek to m*<stack-depth>+<offset> to access an offset into
> something at depth m?
> 

Yes.

>>The i_size of a directory isn't covered by the POSIX standard. IMO,
>>it should be possible to seek in the range of i_size and a following
>>readdir() on the directory should succeed.
> 
> With what defined semantics?  What if an entry is added in between
> seek and readdir?
> 

You have the same problem with regular files. This is a user and not a 
kernel problem.

> 
> Why?  It seems perfectly reasonable that we can return 0 in such
> cases.  Zero seems to make more sense as 'magical/unknown' than say
> any other arbitrary value.
> 

I disagree. Where is the information value of i_size if we always could 
return 0? IMO it should be at least an upper bound for the "number" of 
informations that could actually be read (in terms of a seek offset) 
like it is in the case of regular files. Better, if it is a strict upper 
bound so that you can seek to every value smaller than i_size. For this 
purpose the i_size of directories doesn't need to reflect any unit.

Jan
