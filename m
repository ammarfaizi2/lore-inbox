Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVCVVsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVCVVsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCVVs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:48:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:52411 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262052AbVCVVsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:48:20 -0500
Date: Tue, 22 Mar 2005 22:50:08 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/6] cifs: readdir.c cleanup
In-Reply-To: <42408FCD.1080303@austin.rr.com>
Message-ID: <Pine.LNX.4.62.0503222244380.2683@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503222055150.2683@dragon.hyggekrogen.localhost>
 <42408FCD.1080303@austin.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Steve French wrote:

> Jesper Juhl wrote:
> 
> > Hi Steve,
> > 
> > Here's one more cleanup for a file in fs/cifs - readdir.c (i'm going to
> > follow the order you told me you'd prefer first, then do the remaining files
> > in arbitrary order).
> > I'm going to send the patches inline to make it easy for others to comment
> > if they so choose, but since you had problems with inline patches from me
> > last time I've also placed them online for you :
> > 
[snip]
> >  
> The first looks fine.  I am part way through reviewing the second, and so far
> only found one change (see following) that I question.  I prefer to keep the
> local variables together without a blank line between them.  Is there a global
> Linux style compliance issue here?  By the way, it is not common to use
> typedefs but you will see a few in this function since the network protocol
> specification describes the format of the wire protocol using them and it
> makes the structure names match the standard.
> 
> static char *nxt_dir_entry(char *old_entry, char *end_of_smb)
> {
> -	char * new_entry;
> -	FILE_DIRECTORY_INFO * pDirInfo = (FILE_DIRECTORY_INFO *)old_entry;
> +	char *new_entry;
> +
> +	FILE_DIRECTORY_INFO *pDirInfo = (FILE_DIRECTORY_INFO *)old_entry;
> 
Actually, this is me goofing up. I did intend for all local variables to 
be grouped without a single blank line between them - just one blank line 
*after* the variable block - don't know how this bit snuck in. Thank you 
for catching that.


> I will apply at least a few of them, but I am busy doing a high priority fix
> to handle split transact2 responses (which could cause an oops in ls to some
> servers so is high priority - although it only occurs on large directories,
> and if the server decides to send two transact responses for one request
> (which is not that common) and a search entry is split in certain ways across
> two SMB responses).
> 
I'm fully aware that these patches are low-priority. I don't expect them 
to get anything but "at my convenience" treatment from you.
And should you miss some of them (I'll be sending you quite a few over the 
next few days I expect) I'll just queue them locally and resend at some 
later date (post next Linus release or so), so don't feel pressured to 
look at these if you don't have the time.


-- 
Jesper


