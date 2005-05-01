Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVD3X5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVD3X5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVD3X5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:57:43 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:41709 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261466AbVD3X5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:57:31 -0400
Date: Sun, 1 May 2005 02:10:31 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Steve French <smfrench@austin.rr.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
In-Reply-To: <427387FB.4030901@austin.rr.com>
Message-ID: <Pine.LNX.4.58.0505010158060.6957@be10.lrz>
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
 <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
 <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
 <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@be10.lrz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Steve French wrote:

> There is one remaining issue with mount and umount - the user space 
> utilities.   By the way who maintains
> them these days?   Although the mount utilities allow filesystem 
> specific mount and umount helpers
> to be placed in /sbin and automatically executed for the matching 
> filesystem type, there are a few functions
> that belong in common code - in a system library which today have to be 
> implemented in every helper
> function and of course are implemented in different ways in different 
> distros and
> different tools with possibility of corruption of the /etc/mtab.

For user mounts, there should be no practical way of maintaining mtab,
especially if the users are using private namespaces (as suggested in 
another thread) or if they are supposed to be able to unmount using
a non-suid generic umount.

>   It 
> may be that the file /etc/mtab
> does not matter and that it needs to go away and everyone needs to look 
> at /proc/mounts instead, but
> in the meantime /etc/mtab can easily get out of sync with the actual 
> list of mounts, although that
> usuallly does not prevent unmount from working it may be confusing.

The drawback of /proc/mounts is not showing the -oloop information.
Either it's easy to implement showing that extra information, or you'll
need a ~/.etc/mtab
