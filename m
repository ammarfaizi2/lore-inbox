Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUA3USW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUA3UST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:18:19 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:37248 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263796AbUA3URw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:17:52 -0500
Date: Fri, 30 Jan 2004 12:17:31 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130201731.GY9155@sun.com>
Reply-To: thockin@sun.com
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130114701.18aec4e8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 11:47:01AM -0800, Andrew Morton wrote:
> > directly calling sys_ANYTHING sounds really wrong to me...

It sounded wrong to me, but it gets done ALL OVER.

> Tim, I do think it would be neater to add another entry point in sys.c for
> nfsd and just do a memcpy.

Do you prefer:

a) make a function
	sys.c: ksetgroups(int gidsetsize, gid_t *grouplist)
   which does the same as sys_setgroups, but without the copy_from_user()
   stuff?  The only user (for now, maybe ever) is nfsd.

b) make a function
	sys.c: nfsd_setgroups(int gidsetsize, gid_t *grouplist)
   which does the same as sys_setgroups, but without the copy_from_user()

c) make the nfsd code build a struct group_info and call
   set_current_groups()

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
