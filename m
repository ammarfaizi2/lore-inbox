Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVGTSya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVGTSya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGTSya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:54:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261492AbVGTSxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:53:03 -0400
Message-ID: <42DE9CDC.80900@redhat.com>
Date: Wed, 20 Jul 2005 14:50:04 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Blunck <j.blunck@tu-harburg.de>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <42DE96F2.9070105@tu-harburg.de>
In-Reply-To: <42DE96F2.9070105@tu-harburg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck wrote:

>>
>> Also, how is lseek + readdir supposed to work in general?
>
>
> This is how libc is reading directories (at least on arch s390x):
>
> getdents() != 0
> lseek() to d_off of last dirent
> getdents() != 0
> lseek() to d_off of last dirent
> getdents() == 0
> return
>
> Therefore I really need values that make sense for d_off. Therefore I 
> really need values that make (some kind of) sense for i_size.


Please be aware that not all filesystems treat directories as sequential
files, filled with with odd sized records.  Some directories are distributed
across the entire file system and the d_off fields really contain the
address on disk of the next entry in the directory.  The d_off field is 
really
just a cookie and is not meant to be interpreted as an offset into the
directory.  The lseek() system call is used, but only because that was a
handy way of positioning the pointer into the directory.  It is unfortunate
that the getdents(2) system call was not defined with a cookie as one of
its arguments to indicate where to start fetching entries from.  This would
have reduced the confusion about treating directories as files or not.

    Thanx...

       ps
