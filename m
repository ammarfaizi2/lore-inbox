Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVIIJQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVIIJQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVIIJQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:16:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965110AbVIIJQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:16:04 -0400
Date: Fri, 9 Sep 2005 02:15:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: Re: [PATCH 0/6] jbd cleanup
Message-Id: <20050909021522.1a271e4b.akpm@osdl.org>
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:
>
> The following 6 patches cleanup the jbd code and kill about 200 lines. 
>

Thanks, but I'm not inclined to apply them.

a) Maybe 70-80% of the Linux world uses this filesystem.  We need to be
   very cautious in making changes to it.

b) A relatively large number of people are carrying quite large
   out-of-tree patches, some of which they're hoping to merge sometime. 
   Admittedly more against ext3 than JBD, but there is potential here to
   cause those people trouble.

Plus the switch to list_heads in journal_s has some impact on type safety
and debuggability - I considered doing it years ago but decided not to
because I found I _used_ those pointers fairly commonly in development. 
list_heads are a bit of a pain in gdb (kgdb and kernel core dumps), for
example.

