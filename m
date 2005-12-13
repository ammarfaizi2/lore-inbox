Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVLMNow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVLMNow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVLMNoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:44:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:64212 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932224AbVLMNoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:44:12 -0500
Date: Tue, 13 Dec 2005 13:43:47 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: JANAK DESAI <janak@us.ibm.com>
Cc: chrisw@osdl.org, dwmw2@infradead.org, jamie@shareable.org,
       serue@us.ibm.com, mingo@elte.hu, linuxram@us.ibm.com, jmorris@namei.org,
       sds@tycho.nsa.gov, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call : system call handler function sys_unshare
Message-ID: <20051213134347.GN27946@ftp.linux.org.uk>
References: <1134441680.14136.5.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134441680.14136.5.camel@hobbs.atlanta.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 09:59:50PM -0500, JANAK DESAI wrote:
> +		task_lock(current);
> +
> +		if (new_fs) {
> +			fs = current->fs;
> +			current->fs = new_fs;
> +			put_fs_struct(fs);

Nope.  You can't drop those under a spinlock; leave the pointer e.g. in
new_fs and drop everything after task_unlock().  Incidentally, it allows
to merge cleanup for normal and failure exits.
