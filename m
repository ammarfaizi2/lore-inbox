Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVBXEr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVBXEr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVBXEnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:43:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:50620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261794AbVBXEji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:39:38 -0500
Date: Wed, 23 Feb 2005 20:39:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 files per directory limits
Message-Id: <20050223203915.1c10ceb1.akpm@osdl.org>
In-Reply-To: <20050224031107.GA8656@mtholyoke.edu>
References: <20050224031107.GA8656@mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson <rpeterso@mtholyoke.edu> wrote:
>
> I would like to better understand ext2/3's performance characteristics.
> 
> I'm specifically interested in how ext2/3 will handle a /var/spool/mail
> directory w/ ~6000 mbox format inboxes, handling approx 1GB delivered as
> 75,000 messages daily.  Virtually all access is via imap, w/ approx
> ~1000 imapd processes running during peak load.  Local delivery is via
> procmail, which by default uses both kernel-supported locking calls and
> .lock files.
> 
> I understand that various tuning parameters will have an impact,
> e.g. putting the journal on a separate device, setting the noatime mount
> option, etc.  I also understand that there are other mailbox formats and
> other strategies for locating mail spools (e.g. in user's home
> directories).
> 
> I'm interested in people's thoughts on these issues, but I'm mostly
> interested in whether or not the scenario I described falls within
> ext2/3's designed capabilities.
> 

noatime will help.

increasing the journal size _may_ help.

With 6k files per directory you'll benefit from indexed directories
(htree).  Use `tune2fs -O dir_index'.  dir_index isn't available for ext2.
