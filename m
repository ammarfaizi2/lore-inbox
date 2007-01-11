Return-Path: <linux-kernel-owner+w=401wt.eu-S1030342AbXAKNNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbXAKNNH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbXAKNNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:13:07 -0500
Received: from mail.alkar.net ([195.248.191.95]:50145 "EHLO mail.alkar.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030342AbXAKNNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:13:06 -0500
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
Date: Thu, 11 Jan 2007 16:12:40 +0300
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <200701110324.42920.vs@namesys.com> <45A58C33.4050909@yahoo.com.au>
In-Reply-To: <45A58C33.4050909@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701111612.40701.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thursday 11 January 2007 04:00, Nick Piggin wrote:
> Vladimir V. Saveliev wrote:
> > Hello
> > 
> > On Tuesday 09 January 2007 21:30, Linus Torvalds wrote:
> > 
> >>On Tue, 9 Jan 2007, Malte Schröder wrote:
> >>
> >>>>So something interesting is definitely going on, but I don't know exactly
> >>>>what it is. Why does reiserfs do the truncate as part of a close, if the
> >>>>same inode is actually mapped somewhere else? 
> > 
> > 
> > on file close reiserfs tries to "pack" content of last incomplete page of file into metadata blocks.
> > It should not if that page is still mapped somewhere. 
> > It does not actually truncate, it calls the same function which does truncate, but file size does not change.
> 
> That's racy, unfortunately :P
> 

Sorry, please, explain what is racy.
reiserfs_truncate and reiserfs_release call that function after they have inode's mutex locked.

> > 
> > Please consider the below patch.
> 
> That seems like it would work. Probably papers over your truncate-inside-i_size as well.
> 
