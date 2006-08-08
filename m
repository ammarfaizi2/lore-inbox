Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWHHRX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWHHRX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWHHRX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:23:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29637 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965003AbWHHRX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:23:56 -0400
Subject: Re: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 18:43:14 +0100
Message-Id: <1155058994.5729.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 13:11 -0400, ysgrifennodd Stephen Smalley:
> Does this look sane?  Or do we need a common helper factored from
> disassociate_ctty()?  Why is the locking different for TIOCNOTTY in the
> non-leader case?

The non-leader case for TIOCNOTTY in the base kernel is different
because it is wrong and I've fixed that one.

If you can factor disassociate_ctty out to do what you need I'd prefer
that path so the tty locking actually ends up in the tty layer.

> +	mutex_lock(&tty_mutex);
> +	tty = current->signal->tty;
>  	if (tty) {
>  		file_list_lock();

Looks sane and the lock ordering matches vhangup() which may actually
also do what you want - I'm not 100% sure I follow what SELinux tries to
do here.

