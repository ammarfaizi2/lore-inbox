Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWCHLBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWCHLBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCHLBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:01:39 -0500
Received: from ns.suse.de ([195.135.220.2]:38804 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751313AbWCHLBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:01:38 -0500
Date: Wed, 8 Mar 2006 12:01:35 +0100
From: Jan Blunck <jblunck@suse.de>
To: Balbir Singh <balbir@in.ibm.com>
Cc: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@sw.ru>,
       Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060308110135.GA21187@hasse.suse.de>
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru> <17422.9555.635650.460131@cse.unsw.edu.au> <20060308021731.GA29327@in.ibm.com> <17422.17387.691138.193521@cse.unsw.edu.au> <20060308030500.GB29327@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060308030500.GB29327@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, Balbir Singh wrote:

> 
> wait_on_prunes() breaks out if sb->prunes == 0. What if shrink_dcache_parent()
> now calls select_parent(). select_parent() could still find entries 
> with d_count > 0 and skip them and shrink_dcache_memory() can still cause
> the race condition to occur.
> 
> I think pushing wait_on_prunes() to after shrink_dcache_parent() will
> most likely solve the race.
> 

This is why I used to let shrink_dache_parent() only return after an
unsuccessfull select_parent() after a wait.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
