Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWC0QWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWC0QWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC0QWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:22:48 -0500
Received: from cantor.suse.de ([195.135.220.2]:45770 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750968AbWC0QWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:22:47 -0500
From: Andi Kleen <ak@suse.de>
To: bharata@in.ibm.com
Subject: Re: dcache leak in 2.6.16-git8
Date: Mon, 27 Mar 2006 18:22:27 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603270750.28174.ak@suse.de> <20060327114813.GA11352@in.ibm.com>
In-Reply-To: <20060327114813.GA11352@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271822.28043.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 13:48, Bharata B Rao wrote:
> On Mon, Mar 27, 2006 at 07:50:20AM +0200, Andi Kleen wrote:
> > 
> > A 2GB x86-64 desktop system here is currently swapping itself to death after
> > a few days uptime.
> > 
> > Some investigation shows this:
> > 
> > inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
> > dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0
> > 
> 
> Would it be possible to try out this experimental patch which
> gets some stats from the dentry cache ?

It should be trivial to reproduce by other people. Biggest workload
is kernel compiles and quilt.

After a few hours with -git12 it's already at

dentry_cache      947013 952014    208   19    1 : tunables  120   60    8 : slabdata  50100  50106    480

and starting to go into swap.

I can't imagine I'm the only one seeing this?

I have a few x86-64 patches applied too, but they don't change anything
in this area.

-Andi
