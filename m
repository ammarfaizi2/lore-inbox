Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTIDQMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTIDQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:12:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:22410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265226AbTIDQMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:12:13 -0400
Date: Thu, 4 Sep 2003 09:12:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-Id: <20030904091256.1dca14a5.akpm@osdl.org>
In-Reply-To: <3F576176.3010202@namesys.com>
References: <3F574A49.7040900@namesys.com>
	<20030904085537.78c251b3.akpm@osdl.org>
	<3F576176.3010202@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
>  Perhaps the following is correct?
> 
>      By contrast, ext3 in data=journal and data=ordered modes only guarantees the atomicity of a single write 
>  that does not span a page boundary, and it guarantees that its internal 
>  metadata will not be corrupted even if your application's data is 
>  corrupted after the crash (due to the application spreading what should be committed atomically across more than one block).

Correct != comprehensible ;)

"In all journalling modes ext3 guarantees metadata consistency after a
 crash.  In its data=journal and data=ordered modes ext3 also guarantees that
 user data is consistent with metadata after a crash.

 However ext3 does not provide user data atomicity guarantees beyond the
 scope of a single filesystem disk block (usually 4 kilobytes).  If a
 single write() spans two disk blocks it is possible that a crash partway
 through the write will result in only one of those blocks appearing in the
 file after recovery"

