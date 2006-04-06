Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWDFX0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWDFX0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWDFX0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:26:21 -0400
Received: from queue03-winn.ispmail.ntl.com ([81.103.221.57]:64994 "EHLO
	queue03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932225AbWDFX0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:26:20 -0400
Message-ID: <44356DAA.90209@plan99.net>
Date: Thu, 06 Apr 2006 20:36:10 +0100
From: Mike Hearn <mike@plan99.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it> <E1FRSqP-0000g3-9i@be1.lrz> <443515E1.1000600@plan99.net> <Pine.LNX.4.58.0604061841150.1941@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0604061841150.1941@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bin/foo calls bin/bar refering to /proc/self/fd/999
> bin_2/bar does dup2(open(get_my_exedir()), 999)  ***FUBAR***

So don't do that. Treat it as the same case as sending a file path via 
RPC: make sure it's resolved relative to the namespace the program is in 
and not anything under /proc/self.

In practice most desktop apps use "prefix paths" to locate their own 
data files. They don't usually send those file paths to other processes, 
not even in the case of things like GIMP plugins.

So whilst I agree you have identified a place where it breaks, I don't 
think it invalidates the scheme.

> There may be no "real path" corresponding to /proc/self/fd/4711.

Only in a pathological case like running a program that you then rm -rf 
the prefix of, in which case, you lose whatever happens.

> IMO it's still best to just symlink the program directory to the correct 
> place and make the programs search in e.g. ~/opt/ and /opt/.

That also suffers from namespace conflicts ;)

thanks -mike
