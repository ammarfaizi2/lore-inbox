Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVION4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVION4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVION4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:56:44 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:64746 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030420AbVION4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:56:43 -0400
Subject: Re: [2.6.14-rc1] sym scsi boot hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Anton Blanchard <anton@samba.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0509141716410.8011-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0509141716410.8011-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:56:13 -0400
Message-Id: <1126792573.4821.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 17:33 -0400, Alan Stern wrote:
> On Wed, 14 Sep 2005, James Bottomley wrote:
> > Yes ... really the only case for unprep is when we've partially released
> > the command (like in scsi_io_completion) where we need to tear the rest
> > of it down.
> 
> In other words, in scsi_requeue_command and nowhere else.

Pretty much, yes.

> Or will be prepared for the first time, as in scsi_execute.  As far as I 
> can tell, a new struct request is not set to all 0's.  So if you queue a 
> request with REQ_SPECIAL set and you fail to clear req->special, you're in 
> trouble.  Do you have any idea why this hasn't been causing errors all 
> along?

That's true, it's not.  However ll_rq_blk.c:rq_init() clears req-
>special (and initialises all other important fields).

> Okay, then how does this patch look (moved the routine over to where it 
> gets used, plus two real changes)?

Well ... under pressure to fix this in -mm, I already commited a version
to rc-fixes.  What I did was fully reverse the changes to the
scsi_insert_queue() [the patch I sent Anton].  We can move the unprep
function if you feel strongly about it, but I'm also happy to keep it
where it is.

James


