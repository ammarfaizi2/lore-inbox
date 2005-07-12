Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVGLD66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVGLD66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGLD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:58:58 -0400
Received: from opersys.com ([64.40.108.71]:13326 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262328AbVGLD65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:58:57 -0400
Message-ID: <42D33E99.7030101@opersys.com>
Date: Mon, 11 Jul 2005 23:52:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com> <20050712032424.GA1742@kroah.com>
In-Reply-To: <20050712032424.GA1742@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> Based on the proposed users of this fs, I don't see any.  What ones are
> you saying are not "debug" type operations?  And yes, I consider LTT a
> "debug" type operation :)
> 
> The best part of this, is it gives distros and users a consistant place
> to mount the fs, and to know where this kind of thing shows up in the fs
> namespace.

Except that relayfs contains files that all behave in a very specific
way: as relayfs buffers, while debugfs may contain a variety of different
types of files.

I kind'a see what you're trying to say, and I fully understand that some
debugfs users may indeed use the relayfs fileops to add an entry in
debugfs which serves as a buffer, and that's the very reason we exported
them to boot. But there's something to be said about having a single
filesystem (and therefore tree somewhere in /) which contains entries
dedicated to a single purpose: dump huge amounts of data out of the
kernel and into userspace whether or not the system is being debuged.

>From a user point of view, it sounds awfully weird if they're using
"debugfs" on a production system ...

> Last I looked, this was not possible.  Has this changed in the latest
> version?

Here's from 2.6.13-rc2-mm1 fs/relayfs/inode.c
> +EXPORT_SYMBOL_GPL(relayfs_open);
> +EXPORT_SYMBOL_GPL(relayfs_poll);
> +EXPORT_SYMBOL_GPL(relayfs_mmap);
> +EXPORT_SYMBOL_GPL(relayfs_release);
> +EXPORT_SYMBOL_GPL(relayfs_file_operations);
> +EXPORT_SYMBOL_GPL(relayfs_create_dir);
> +EXPORT_SYMBOL_GPL(relayfs_remove_dir);

It's been there ever since you've asked for it earlier this year :)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
