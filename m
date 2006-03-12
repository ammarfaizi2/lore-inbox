Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCLXDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCLXDd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCLXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:03:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:16568 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751374AbWCLXDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:03:32 -0500
Date: Mon, 13 Mar 2006 00:03:31 +0100
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Message-ID: <20060312230331.GO4243@hasse.suse.de>
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de> <17425.26668.678359.918399@cse.unsw.edu.au> <20060310123153.GN4243@hasse.suse.de> <17428.39221.861124.797480@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17428.39221.861124.797480@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, Neil Brown wrote:

> No you don't.

Err, you are right. But this brings a new idea to my mind: why don't we use
s_umount to prevent umounting while we prune one dentry? Something like:

  if (down_read_trylock()) {
    if (s_root)
      prune_one_dentry()
    up_read()
  }
  // else just skip it

So maybe our prunes counter isn't the only way to go. Comments?

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
