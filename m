Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJXJQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTJXJQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:16:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262101AbTJXJQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:16:40 -0400
Date: Fri, 24 Oct 2003 10:16:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH,RFC] umsdos FS in 2.6.x
Message-ID: <20031024091639.GS7665@parcelfarce.linux.theplanet.co.uk>
References: <20031023235327.3ff12194.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023235327.3ff12194.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 11:53:27PM -0700, Randy.Dunlap wrote:
> 
> This patch enables umsdos filesystem to build, although a few things
> still need to be fixed, such as:
> 
> . updating {acm}time, since those fields changed from time_t to
>   struct timespec:  for backward compatibility, do these fields
>   need to remain as time_t (i.e., keep the same size) ?
> 
> . I kept using a 16-bit dev_t.  Does this need to change?
>   If yes, to 32-bit, or to use whatever size is passed to it?
> 
> . fill_super/read_super probably still need a little bit of work,
>   such as which inode_operations structure to use.
> 
> . I'll begin testing it soon.

* struct inode reuse between msdos and umsdos is FUBAR.  Allocation/freeing
  of inode is controlled by its ->i_sb.  So is location of struct inode within
  the allocated object.  That's where umsdos got really broken and AFAICS the
  only more or less sane way to handle that crap is separation of msdos and
  umsdos inode/dentry/superblock, so that the latter would refer the former.

The rest is more or less trivial; compile fixes, mostly from prototype changes
for methods.  Inode reuse problem is where the real PITA is and it will take
a serious work to fix.
