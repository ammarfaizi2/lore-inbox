Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWCXX7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWCXX7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWCXX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:58:59 -0500
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:43669 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750713AbWCXX67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:58:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YwY9xAmGOlablLOlVgmmd5c0ZHbzC0d9+V4NH2QtSAAn+BPuDybFLpb6G18GFRIZWOpfozeqcNFtn+GPYENvkvEamfJ7xFd/PTGs9/EZHSnBp36xZRXjbbn0LNYt7JvzX+vD5kXJUl4DKzBWFRE/Xpm1RXHINLvz3PMa4qlmGXw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Date: Sat, 25 Mar 2006 00:58:57 +0100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org>
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603250058.57700.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 23:45, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:

> > Unplugged pages are allocated and then madvise(MADV_REMOVE), 

> > This patch also removes checking for /dev/anon on the host, which is
> > obsoleted by MADVISE_REMOVE.

>  * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
>  * Other filesystems return -ENOSYS.

> Are you expecting that this memory is backed by tmpfs?

Yes, that's the recommended configuration, and we're going to move the default 
position for the backing file to /dev/shm.

However, it's bogus to miss any error handling - possibly not returning err is 
wanted (dunno) because Jeff wants to pretend it succeeded anyway, but at 
least a printk() to inform the user that memory must lay on tmpfs is 
required.

> +int os_drop_memory(void *addr, int length)
> +{
> +     int err;
> +
> +     err = madvise(addr, length, MADV_REMOVE);
> +     if(err < 0)
> +             err = -errno;

Jeff, did you mean the "return _0_" rather than "return err" below? It's 
incoherent with the existance of the "err" local.

> +     return 0;
> +}

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
