Return-Path: <linux-kernel-owner+w=401wt.eu-S932830AbWL0N41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWL0N41 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWL0N41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:56:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60860 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830AbWL0N40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:56:26 -0500
Date: Wed, 27 Dec 2006 13:56:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: Racy /proc creations interfaces
Message-ID: <20061227135624.GP17561@ftp.linux.org.uk>
References: <20061227134223.GA6044@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227134223.GA6044@localhost.sw.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 04:42:23PM +0300, Alexey Dobriyan wrote:
> 
>    	struct proc_entry_raw foo_pe_raw = {
> 		.owner = THIS_MODULE,
> 		.name = "foo",
> 		.mode = 0644,
> 		.read_proc = foo_read_proc,
> 		.data = foo_data,
> 		.parent = foo_parent,
> 	};
> 
> 	pde = create_proc_entry(&foo_pe_raw);
> 	if (!pde)
> 		return -ENOMEM;
> 
>    where "struct proc_entry_raw" is cut down version of "struct proc_dir_entry"

Ewwwwwwwwwwwwwww

Please, please no.  Especially not .parent.  If anything, let's add a
helper saying "it's all set up now".  And turn create_proc_entry()
into a macro that would pass THIS_MODULE to underlying function and
call that helper, so that simple cases wouldn't have to bother at all.
