Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKOUvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTKOUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:51:04 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:48005 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262086AbTKOUvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:51:02 -0500
Date: Sat, 15 Nov 2003 20:50:55 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311152045310.743-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> If you mean that read(2) can decide to return less than full user buffer even
> though more data is available - tough, that's something userland *must* be
> able to deal with.

I think I now understand better what you mean. And that is not what I 
meant. Yes, of course userspace must be able to deal with less data than 
what it asked for. I agree.

But I was referring to the complication on the kernel side, whereby if the 
data (collectively, all the entries) is more than 1 page then ->stop() 
must be called and a page returned to user and then the kernel must build 
another page but all it knows is the integer 'offset'. Anything could have 
happened to the list (task list in this case) since ->stop() routine 
dropped the spinlock. So, it is not obvious from which position to 
start building the data for the new page. 

Looking at mm/slab.c implementation I see that it just walks the integer 
distance from the head of the list. Simple but not 100% correct, I think. 
I.e. it can miss an entry if the list has changed between two read(2)s.

Kind regards
Tigran

