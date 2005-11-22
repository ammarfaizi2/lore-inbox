Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVKVWQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVKVWQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVKVWQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:16:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030201AbVKVWQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:16:24 -0500
Date: Tue, 22 Nov 2005 14:16:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: jonathan@jonmasters.org
Cc: jonmasters@gmail.com, cp@absolutedigital.net, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
Message-Id: <20051122141628.41f3134f.akpm@osdl.org>
In-Reply-To: <35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	<20051116005958.25adcd4a.akpm@osdl.org>
	<20051119034456.GA10526@apogee.jonmasters.org>
	<20051121233131.793f0d04.akpm@osdl.org>
	<35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters <jonmasters@gmail.com> wrote:
>
> On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> > That still does the wrong thing.  Put in a write-protected floppy, try to
> > write to it and it says -EROFS.  Then pop the WP switch and try to
> > write to it again and it wrongly claims EPERM.  A second attempt to
> > write will succeed.
> 
> The problem is that we need to wait until the floppy driver next
> checks the read status on the drive. I think to get it completely
> right will take moving bits of the floppy driver around, unless I'm
> being stupid. I'm planning to do that too though.
> 

In the meanwhile I think we should revert back to the 2.6.14 version of
floppy.c - the present problem is probably worse than the one which it
kinda-fixes.
