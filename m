Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWEEUod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWEEUod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWEEUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:44:33 -0400
Received: from mx.freeshell.ORG ([192.94.73.18]:26091 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S1751771AbWEEUod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:44:33 -0400
Date: Fri, 5 May 2006 20:44:10 +0000 (UTC)
From: Alexey Toptygin <alexeyt@freeshell.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
In-Reply-To: <200605052238.26834.ak@suse.de>
Message-ID: <Pine.NEB.4.62.0605052040250.27826@ukato.freeshell.org>
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
 <200605052238.26834.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006, Andi Kleen wrote:

> With your change there wouldn't be any sign extension and rw_verify_area
> couldn't reject negative values them anymore.
>
> I think it would be a wrong change because it would differ from a native
> 32bit kernel.

No...

On a 32 bit kernel (and on a 64 bit kernel using the native interface), 
count is passed to sendfile as unsigned. rw_verify_area explicitly casts 
to signed before checking for negativeness. The only place anywhere in the 
kernel that count is signed (other than where rw_verify area explicitly 
casts it for one test) is in the declaration of sys32_sendfile in the 
x86_64 compat code. I'm pretty sure it's supposed to be unsigned there 
too, and the current code is a typo.

 			Alexey
