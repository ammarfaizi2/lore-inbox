Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272765AbTHKQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTHKQ0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:26:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272821AbTHKQXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:23:31 -0400
Message-ID: <3F37C2EB.5050503@pobox.com>
Date: Mon, 11 Aug 2003 12:23:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] file extents for EXT3
References: <m3ptjcabey.fsf@bzzz.home.net> <3F3791C8.4090903@pobox.com> <20030811095518.T7752@schatzie.adilger.int>
In-Reply-To: <20030811095518.T7752@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Ext2/3 uses feature flags instead of version numbers to indicate such
> changes.  Version numbers are a poor way of indicating whether a change
> is compatible or not compared to feature flags.  For example, if you bump
> the minor number to indicate a "compatible" change it means that any
> code that pretends to support version x.y features also needs to support
> all features <= y and all features <= x.


What I'm talking about is more high level than that, and probably 
touches on "marketing" aspects a bit:

The net effect of slowly sliding features into ext2/3 via feature flags 
creates the poor situation we have today:  your filesystem, and your 
kernel, may or may not support the featureset you're looking for.  Sure, 
slowly sliding features into existing filesystems can be made to work 
with compatibility flags and careful thought.

However, I argue that there should be an ext2/3 filesystem feature 
freeze.  And in this regard I am talking about _software_ versions, not 
filesystem formats.  ext4 should be where the bulk of the new work goes. 
  Please -- leave ext3 alone!  It's still being stabilized.

Of course, the other alternative is to rename ext3 to "linuxfs", add a 
"no journal at all" mode, and remove ext2.  But I prefer my "ext4" 
solution :)

Anyway, I am hoping that situation will be fixed, not propagated via 
feature flags until the end of time as a Good Thing(tm).  It is _not_ 
smart to create features like ACLs or htrees, and then use those 
features under different versions of kernels.  That strategy guarantees 
your metadata will get out of sync with other metadata, in the name of 
backward compatibility.

	Jeff



