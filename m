Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJMKVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJMKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:21:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:1168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261640AbTJMKVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:21:17 -0400
Date: Mon, 13 Oct 2003 03:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org, vs@thebsh.namesys.com,
       nikita@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-Id: <20031013032431.1ed40c25.akpm@osdl.org>
In-Reply-To: <3F8A3CE0.4060705@namesys.com>
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
	<20031012071447.GJ8724@pegasys.ws>
	<3F8A3CE0.4060705@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> In theory it is cleaner and purer to do it the way we did.  In practice, 
>  Alex's problem seems like a real one, and I don't know how hard it is to 
>  change tar to do the right thing.  We'll discuss it in a small seminar 
>  today.

It would be best to make this change.  minix, ext2 and ext3 do set ctime,
so it is "the Linux standard".

btw, this code:

      old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
      new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
      old_inode->i_ctime = CURRENT_TIME;

should avoid evaluating CURRENT_TIME three times: is has some computational
cost and if an interrupt happens at the wrong time you end up with
differing times in the inode(s).


