Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUFNJzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUFNJzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUFNJzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 05:55:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18899 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262176AbUFNJzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 05:55:36 -0400
Date: Mon, 14 Jun 2004 10:55:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614095529.GA11563@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Cesar Eduardo Barros <cesarb@nitnet.com.br>,
	linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
References: <20040612011129.GD1967@flower.home.cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040612011129.GD1967@flower.home.cesarb.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 10:11:29PM -0300, Cesar Eduardo Barros wrote:
> (not subscribed to lkml, please CC: me on replies)
> 
> This patch adds support for the O_NOATIME open flag (GNU extension):
> 
> int O_NOATIME  	Macro
>   If this bit is set, read will not update the access time of the file.
>   See File Times. This is used by programs that do backups, so that
>   backing a file up does not count as reading it. Only the owner of the
>   file or the superuser may use this bit.
> 
> It is useful if you want to do something with the file atime (for
> instance, moving files that have not been accessed in a while to
> somewhere else, or something like Debian's popularity-contest) but you
> also want to read all files periodically (for instance, tripwire or
> debsums).
> 
> Currently, the program that reads all files periodically has to use
> utimes, which can race with the atime update:

Any chance we could change the flag to also not update mtime and ctime
for updates on a fd opened with it (and renaming it to O_INVISIBLE for
example).  That's needed for your above moving infrequently used files
away scenario (aka a HSM)

