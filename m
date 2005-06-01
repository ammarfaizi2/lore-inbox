Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFAFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFAFHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFAFGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:06:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:10642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261260AbVFAFCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:02:07 -0400
Date: Tue, 31 May 2005 22:01:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: timur.tabi@ammasso.com
Subject: Re: get_user_pages() and process termination
Message-Id: <20050531220106.357059ff.akpm@osdl.org>
In-Reply-To: <429CB7CF.2000200@ammasso.com>
References: <429CB7CF.2000200@ammasso.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> If I call get_user_pages() on some pages owned by a process, and then the process exits, 
>  are the pages still pinned, or is there some kind of automatic cleanup?

get_user_pages() will pin the pages for you.  You now own the additional
refcount on those pages.  You must run put_page() against each page to
avoid leaking them.

