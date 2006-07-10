Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWGJUJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWGJUJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWGJUJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:09:16 -0400
Received: from pat.uio.no ([129.240.10.4]:40183 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422695AbWGJUJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:09:15 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44B01DEF.9070607@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org>
	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>
	 <1152135740.22345.42.camel@lade.trondhjem.org>  <44B01DEF.9070607@tmr.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 16:08:55 -0400
Message-Id: <1152562135.6220.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 17:04 -0400, Bill Davidsen wrote:
> No, I didn't quite mean a manual touch, but a system call to "close and 
> set time to high resolution" for files where time uniformity is 
> important. Consider that in most cases the inodes times are set by the 
> host machine clock, which I close the change reflects the fileserving 
> host idea of time. If there were a call to close a file and set the 
> times like touch, then that could be used, for both local and network files.

Close should never update the time since that would be a violation of
POSIX rules. Normally, an NFS client will never need to update the time:
RPC calls like WRITE, READ and SETATTR will automatically do it for us
whenever necessary.

Cheers,
  Trond

