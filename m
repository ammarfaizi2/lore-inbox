Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279535AbRJ2VTG>; Mon, 29 Oct 2001 16:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279538AbRJ2VTB>; Mon, 29 Oct 2001 16:19:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16892
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279535AbRJ2VSq>; Mon, 29 Oct 2001 16:18:46 -0500
Date: Mon, 29 Oct 2001 13:19:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Taral <taral@taral.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: /proc/net/ip_conntrack problems
Message-ID: <20011029131916.D20280@mikef-linux.matchmail.com>
Mail-Followup-To: Taral <taral@taral.net>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011028220854.A17685@taral.net> <3974.1004329672@kao2.melbourne.sgi.com> <20011028223651.B17685@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011028223651.B17685@taral.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 10:36:51PM -0600, Taral wrote:
> On Mon, Oct 29, 2001 at 03:27:52PM +1100, Keith Owens wrote:
> > Some /proc output is blocked, it will only return complete lines.  If
> > your buffer is not big enough to hold the next line then you don't get
> > anything at all.  Try cat /proc/net/ip_conntrack | wc.
> 
> So why are 2 lines missing when I change the blocking factor from 256 to
> 512? Even cat reads in 16k blocks... Also:
> 
> % dd if=/proc/net/ip_conntrack bs=512 | perl -ne 'print length()."\n"'
> 0+2 records in
> 0+2 records out
> 153
> 138
> 169
> 151
> 167
> 139
> 
> No line is longer than 256 chars, so why are 2 lines missing when I read
> in 256 byte blocks?
> 

Because you would need the buffer size to hit the moving target of any of
the boundaries of the lines.  So you would need (for the example above)
buffer sizes of:
153
291
460
611
778
778

16k blocks would hold all of those...

IIRC, proc files have trouble returning output larget than one page (4k)...

Mike
