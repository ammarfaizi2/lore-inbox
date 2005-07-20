Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVGTSqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVGTSqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVGTSqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:46:20 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:12404 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261477AbVGTSqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:46:18 -0400
Message-ID: <42DE9C71.7090903@tu-harburg.de>
Date: Wed, 20 Jul 2005 20:48:17 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org>
In-Reply-To: <20050720181101.GB11609@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
>>To my understanding, you can lseek to any "proper" offset inside a
>>directory.  Proper means that the offset marks the beginning of a
>>new dirent (or end of file) in the interpretation of the filesystem.
> 
> 
> But you can never tell where these are in general.
> 
> 

I don't want to tell where these are in general, I need an easy way to 
seek to the m'th directory + offset position without reading every 
single dirent. With i_sizes != 0 it is straight forward to use "the sum 
of the m directory's i_sizes + offset" as the f_pos to seek to. For this 
purpose it is not necessary to have a "honest" i_size as long as the 
i_size is bigger than the offset of the last dirent in the directory.

> 
> I don't see why or how this can be true in general (it might be, but I
> don't see how myself).  If we are half way through scanning a
> directory and people start messing with it we could end up somewhere
> bogus (in which case f_op->readdir I guess is expected to try and do
> something sane here?)
> 

E.g.: ext2_validate_entry() is called if filp->f_version != 
inode->i_version.

> 
>>Reopening the same directory may result in a formerly proper offset
>>isn't anymore.
> 

Which is a user problem again. Might be that you are opening a different 
directory with the same name ... or even a regular file!

Jan
