Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVATOvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVATOvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 09:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVATOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 09:51:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:16588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262145AbVATOvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 09:51:32 -0500
Date: Thu, 20 Jan 2005 06:50:46 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
Message-ID: <20050120145046.GF13036@kroah.com>
References: <41EF4E74.2000304@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EF4E74.2000304@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:23:48AM -0500, Karim Yaghmour wrote:
> 
> I've reworked the relayfs patch extensively. The API and internals
> have been heavily purged. The patch is in fact almost HALF! its
> original size, loosing 90KB and going from 200KB to 110KB.

Hm, how about this idea for cutting about 500 more lines from the code:

Why not drop the "fs" part of relayfs and just make the code a set of
struct file_operations.  That way you could have "relayfs-like" files in
any ram based file system that is being used.  Then, a user could use
these fops and assorted interface to create debugfs or even procfs files
using this type of interface.

As relayfs really is almost the same (conceptually wise) as debugfs as
far as concept of what kinds of files will be in there (nothing anyone
would ever rely on for normal operations, but for debugging only) this
keeps users and developers from having to spread their debugging and
instrumenting files from accross two different file systems.

Just an idea...

thanks,

greg k-h
