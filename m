Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUFSKHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUFSKHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFSKHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:07:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:12217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265446AbUFSKHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:07:35 -0400
Date: Sat, 19 Jun 2004 03:06:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, bcasavan@sgi.com
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Message-Id: <20040619030637.5580b25e.akpm@osdl.org>
In-Reply-To: <1087605785.8188.834.camel@cube>
References: <1087605785.8188.834.camel@cube>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> > Doing the cache in the kernel is the wrong place. This should be fixed
>  > in user space.
> 
>  No way, because:
> 
>  1. kernel modules may be loaded or unloaded at any time

Poll /proc/modules?

>  2. the /proc/*/wchan files don't provide both name and address

/proc/stat has the address, /proc/kallsyms gives the symbol?

>  I'd be happy to make top (and the rest of procps) use a cache
>  if those problems were addressed. I need a signal sent on
>  module load/unload, or a real /proc/kallsyms st_mtime that I
>  can poll. I also need to have the numeric wchan address in
>  the /proc/*/wchan file, such that it is reliably the same
>  thing as the function name already found there.

Updating mtime on /proc/modules may be more logical, or even both.

Or put a modprobe sequence number somewhere in /proc and look for changes
in that.

It definitely needs to be fixed, but it doesn't seem that adding code to
the kernel is needed.

