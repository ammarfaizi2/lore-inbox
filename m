Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTL1SRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 13:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTL1SRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 13:17:52 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:53480 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261872AbTL1SRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 13:17:44 -0500
Date: Sun, 28 Dec 2003 13:03:41 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] O_DIRECTORY|O_CREAT handling
Message-ID: <20031228180341.GA1134@pimlott.net>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <3FE56A97.3060901@redhat.com> <20031221105110.GA1323@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221105110.GA1323@alpha.home.local>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 11:51:10AM +0100, Willy Tarreau wrote:
>   base_dir="/tmp/tmpdir"; 
>   do {
>      rnd=random();
>      sprintf(dir, "%s%d", base_dir, rnd);
>   } while (!mkdir(dir, 0700);
>   /* now I'm guaranteed that I'm the first to get this dir, */
>   /* and only my UID can work in it */
>   chdir(dir);
>   
> So the only race would be someone working with the same UID (or root) removing
> the directory and replacing it with another one (or a symlink or anything)
> between mkdir() and chdir().

If /tmp isn't sticky, anyone can do this.  I think this is the
scenario Ulrich was referring to.

Andrew
