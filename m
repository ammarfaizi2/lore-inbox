Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUEWFfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUEWFfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 01:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUEWFfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 01:35:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12470 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262256AbUEWFfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 01:35:39 -0400
Date: Sun, 23 May 2004 06:35:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: consistent ioctl for getting all net interfaces?
Message-ID: <20040523053538.GW17014@parcelfarce.linux.theplanet.co.uk>
References: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 09:28:28PM -0700, Joshua Kwan wrote:
> Hi,
> 
> I'm interested in not having to parse /proc/net/dev to get a list of all
> available (not necessarily even up) interfaces on the system. I
> investigated the ioctl SIOCGIFCONF, but it seems to behave differently on
> 2.4 and 2.6 series kernels, e.g. sometimes it won't return all interfaces.
> 
> Is there some end-all ioctl that does what I want, or am I forever doomed
> to process /proc/net/dev (in C, no less..)?

ASCII is tough, let's go shopping?

	char name[17];
	FILE *in = fopen("/proc/net/dev", "r");
	if (!in)
		die("can't open");
	fscanf(in, "%*[^\n]\n%*[^\n]");		/* skip two lines */
	while (fscanf(in, " %16[^:]:%*[^\n]", name) == 1)
		do_whatever_you_want(name);

That you are calling "forever doomed"?  Wimp...
