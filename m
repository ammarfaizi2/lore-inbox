Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264024AbUDVNkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbUDVNkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUDVNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:40:45 -0400
Received: from unthought.net ([212.97.129.88]:35532 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264024AbUDVNko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:40:44 -0400
Date: Thu, 22 Apr 2004 15:40:43 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Stephan T. Lavavej" <stl@nuwen.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process Creation Speed
Message-ID: <20040422134043.GL30687@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Stephan T. Lavavej" <stl@nuwen.net>, linux-kernel@vger.kernel.org
References: <20040419120957.GB3764@convergence.de> <200404191245.i3JCjqal006292@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404191245.i3JCjqal006292@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 05:44:12AM -0700, Stephan T. Lavavej wrote:
> Thanks to all who have responded.
> 
...
> 
> I am writing a web-based forum entirely in C++, rejecting interpreted
> languages (Perl, PHP, ASP, etc.) and relational databases (MySQL,
> PostGreSQL, etc.) entirely.  My forum consists of "kiddy" CGI processes
> which talk over the network to a persistent "mommy" daemon who keeps all
> forum state in main memory.

You could consider loading your .o as an apache module, rather than
executing it as a CGI program.

I was involved in one project where we did this with good success. Even
segfaults in our module would "only" take down one of the Apache
sub-processes, so while they incur performance overhead (and of course
should be fixed no matter what - which luckily is very easy (using for
example { if (!fork()) abort(); } to create snapshot coredumps)), it's
not catastrophic.  It's entirely realistic to write a good module for
Apache in a fairly short timespan.

 / jakob

