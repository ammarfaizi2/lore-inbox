Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWEJWpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWEJWpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWEJWpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:45:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13715 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965047AbWEJWpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:45:54 -0400
Date: Wed, 10 May 2006 23:45:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510224549.GI27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org> <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510.153129.122741274.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 03:31:29PM -0700, David S. Miller wrote:
> From: Al Viro <viro@ftp.linux.org.uk>
> Date: Wed, 10 May 2006 23:10:24 +0100
> 
> > But that's the argument in favour of using diff, not shutting the
> > bogus warnings up...
> 
> IMHO, the tree should build with -Werror without exception.
> Once you have that basis, new ones will not show up easily
> and the hard part of the battle has been won.
> 
> Yes, people will post a lot of bogus versions of warning fixes, but
> we're already good at flaming those off already :-)

Alternatively, gcc could get saner.  Seriously, some very common patterns
trigger that shit - e.g. function that returns error or 0 and stores
value to *pointer_argument in case of success.  It's a clear regression
in 4.x and IMO should be treated as gcc bug.
