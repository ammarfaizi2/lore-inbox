Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUGJLyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUGJLyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUGJLyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:54:07 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:35764 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266216AbUGJLyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:54:04 -0400
Date: Sat, 10 Jul 2004 13:54:04 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Alberto Bertogli <albertogli@telpin.com.ar>, linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-ID: <20040710115404.GA11420@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>,
	Alberto Bertogli <albertogli@telpin.com.ar>,
	linux-kernel@vger.kernel.org
References: <20040709030637.GB5858@telpin.com.ar> <20040709023948.59497dca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709023948.59497dca.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:39:48AM -0700, Andrew Morton wrote:

> It depends on the Linux filesystem.  On ext3, for example, fsync() will
> sync all of the filesytem's metadata (and data in journalled and ordered
> data mode).

I've noticed that on ext3, SQLite transactions are nearly useless, with the
smallest transactions causing 5 megabyte/s writout activity based on
relatively small writes. kjournald bore a large part of that according to
laptop_mode's block dump.

Do we actually need to flush the journal on fsync? I'm no fs theorist but I
wonder if having data in the journal isn't good enough - in case of failure,
the data will be there on recovery?



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
