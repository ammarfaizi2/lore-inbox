Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUJTVdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUJTVdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJTVcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:32:48 -0400
Received: from hera.kernel.org ([63.209.29.2]:63619 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269050AbUJTVbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:31:49 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 20 Oct 2004 21:31:38 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cl6lfq$jlg$1@terminus.zytor.com>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1098307898 20145 127.0.0.1 (20 Oct 2004 21:31:38 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 20 Oct 2004 21:31:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041017133537.GL7468@marowsky-bree.de>
By author:    Lars Marowsky-Bree <lmb@suse.de>
In newsgroup: linux.dev.kernel
> 
> This actually forbids recvmsg() to return EAGAIN and EWOULDBLOCK as
> has been suggested. EIO seems to be the best fit.
> 
> But I'd have to agree that blocking on recvmsg() after select() has
> indicated ready to read does violate the specification, unless the
> socket has actually been opened with O_NONBLOCK.
> 

EIO seems to be The Right Thing[TM]... it pretty much says "yes, we
received something, but it was bad."  What isn't clear to me is how
applications react to EIO.  It could easily be considered a fatal
error... :-/

	-hpa
