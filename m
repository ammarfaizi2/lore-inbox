Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUGZJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUGZJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGZJKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:10:24 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:14043 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S265091AbUGZJKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:10:08 -0400
Date: Mon, 26 Jul 2004 11:10:04 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: linux-kernel@vger.kernel.org
Subject: OOM-killer going crazy. (was: Re: memory not released after using cdrecord/cdrdao)
Message-ID: <20040726091004.GA32403@ii.uib.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41045EBE.8080708@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 09:30:38PM -0400, Ed Sweetman wrote:
> 
> Indeed, i burned a smaller cd and got very similar results.  

Same here.. After upgrading to 2.6.8-rc2 the OOM-killer is going crazy.
It's particularly angry at the backup client 'dsmc' (from Tivoli Storage
Manager).  I'm monitoring its usage with 'top', and 'dsmc' is not using
more than ~150MB in either size or RSS when the OOM-killer takes it down.

The 'dsmc'-process is reporting that it's processed 2,719,000 files, and
transfered 164.34 MB when it gets killed. i.e. it's traversed a lot of
files, but only read about 164 MB data, so it shouldn't have filled up any
buffer cache... 

The system still has lots of free memory (~900 MB), and also 2 GB of
unused swap. Actually there's 0K used swap..??  

I've tried turning on vm.overcommit_memory, but it had no effect. Also
tried changing the swappiness both up to 90% and down to 10%, but it
never uses any swap.. ???

BTW: I had no OOM-killer problems on 2.6.7.


  -jf
