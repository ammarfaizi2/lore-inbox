Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVG2AZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVG2AZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVG2AY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:24:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbVG2AY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:24:28 -0400
Date: Thu, 28 Jul 2005 17:23:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Bellon <mbellon@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to
 /proc/mounts
Message-Id: <20050728172302.1b04511a.akpm@osdl.org>
In-Reply-To: <42E97236.6080404@mvista.com>
References: <42E97236.6080404@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Bellon <mbellon@mvista.com> wrote:
>
> If /etc/mtab is a regular file all of the mount options (of a file 
>  system) are written to /etc/mtab by the mount command. The quota tools 
>  look there for the quota strings for their operation. If, however, 
>  /etc/mtab is a symlink to /proc/mounts (a "good thing" in some 
>  environments)  the tools don't write anything - they assume the kernel 
>  will take care of things.
> 
>  While the quota options are sent down to the kernel via the mount system 
>  call and the file system codes handle them properly unfortunately there 
>  is no code to echo the quota strings into /proc/mounts and the quota 
>  tools fail in the symlink case.

hm.  Perhaps others with operational experience in that area can comment.

>  The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 
>  necessary hooks. The show_options function of each file system in these 
>  patches currently deal with only those things that seemed related to 
>  quotas; especially in the EXT3 case more can be done (later?).

It seems sad to do it in each filesystem.  Is there no way in which we can
do this for all filesystems, in a single place in the VFS?

