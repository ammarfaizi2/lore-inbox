Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264805AbUDWMsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbUDWMsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbUDWMsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:48:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24038 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264791AbUDWMsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:48:21 -0400
Date: Fri, 23 Apr 2004 14:48:20 +0200
From: Jan Kara <jack@suse.cz>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: holding a reference on an inode?
Message-ID: <20040423124820.GI15248@atrey.karlin.mff.cuni.cz>
References: <1082507296.3133.4.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082507296.3133.4.camel@vertex>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I am writing a kernel module, and I would like to allow user space to
> hand me a FILE, and then for my kernel module to keep a reference on its
> inode regardless what the user space program does with the FILE. 
> 
> 1) Is this good practice?
  Generally passing a file is not a problem - a lot of other syscalls
does that... The question is what would you like to do with the file
(you must be rather careful because you should not trust the contents of
the file, the contents can change etc...).

> 2) How do I get notified when the filesystem the inode is on is being   
> unmounted so I can release my reference? So that I don't block the
> unmount.
  The umount calls a filesystem callback umount_begin() which you could
probably use...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
