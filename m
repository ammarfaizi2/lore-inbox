Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUGLSAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUGLSAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUGLR6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:58:09 -0400
Received: from hera.kernel.org ([63.209.29.2]:13010 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266914AbUGLR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:56:40 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: XFS: how to NOT null files on fsck?
Date: Mon, 12 Jul 2004 17:56:11 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccujbr$unl$1@terminus.zytor.com>
References: <20040710184357.GA5014@taniwha.stupidest.org> <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net> <20040711215446.GA21443@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089654971 31478 127.0.0.1 (12 Jul 2004 17:56:11 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jul 2004 17:56:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040711215446.GA21443@hh.idb.hist.no>
By author:    Helge Hafting <helgehaf@aitel.hist.no>
In newsgroup: linux.dev.kernel
> > 
> No, it doesn't.
> 
> close() will flush the C library buffer.  That means the data
> moves from theose buffers to the pagacache. The program crashing
> after that will have no effect on the file.  It can still
> be lost if the _kernel_ crashes though.
> If you want the pagecache flushed to disk, use fsync (or sync)
> 

No it won't, since if you're using file descriptors there *is* no C
library buffer.  fclose() will, though, and then call close().

	-hpa
