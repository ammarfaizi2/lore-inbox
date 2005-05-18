Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVERGCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVERGCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 02:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVERGCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 02:02:19 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:58894 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S262102AbVERGCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 02:02:09 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <OF18BF4790.4053D6B0-ON88257004.0063F34D-88257004.006557CA@us.ibm.com>
References: <OF18BF4790.4053D6B0-ON88257004.0063F34D-88257004.006557CA@us.ibm.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116436224.2428.16.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 May 2005 13:10:24 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 14:26, Bryan Henderson wrote:
> >Yes, we're sure to abort the operation, but we can't use 
> >exit(EXIT_FAILURE) directly. For HA environment, we should
> >identify the cause of the error, take correspondent action,
> >right? So we need to get the right error.
> 
> You mean a computer program will take the correspondent action?  I think 
> it would take a remarkably intelligent program to respond appropriately to 
> particular failures -- especially if the program isn't tailored to a very 
> specific environment.  In practice, all I ever see a binary response -- 
> one for success, one for failure.  The errno is used at most for giving a 
> three word explanation to a human so the human can respond.  That's why 
> people don't take this issue seriously.
> 
> "pass the errno up" is definitely a layering violation and cheap 
> architecture.  It's why the 3 word description you get is often 
> meaningless -- it's telling you about a failure deep in computations you 
> aren't even supposed to know about.  I myself stay away from errnos where 
> possible and produce error information in English text, with each layer 
> adding information meaningful at that layer.  But where we're sticking 
> with classic errnos, it just doesn't make sense to work really hard on it.
> 
> Nonetheless, I think there's broad agreement, and the current discussion 
> is consistent with it, that if write() fails due to an I/O error, the 
> errno should be EIO.  Whether it's formally specified or not, the standard 
> is there.  That ext3 returns EROFS is either a bug or an implementation 
what standard do you mean?
> convenience compromise or a case where the actual failure is more 
> complicated than you imagine (maybe an operation fails and gets retried -- 
> the original failure caused an automatic switch to R/O and the retry 
> failed because of the R/O status.  Errnos are definitely not sufficient to 
> give you the whole chain of causation for a failure -- if it gives you 
> even the immediate cause, you should feel fortunate).
I suggest you visit our project, see the testing result,
http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency
For each test case, different FS returns different result.
>From user's perspective, it's really annoying, so, there should be a 
standard which constraints the error type. Otherwise, different fs
can return whatever they want, regardless of the user's need. 
> --
> Bryan Henderson                          IBM Almaden Research Center
> San Jose CA                              Filesystems
> 


