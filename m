Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWEEV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWEEV22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWEEV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:28:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42909 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751789AbWEEV21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:28:27 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Toptygin <alexeyt@freeshell.org>
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
Date: Fri, 5 May 2006 23:28:21 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org> <200605052238.26834.ak@suse.de> <Pine.NEB.4.62.0605052040250.27826@ukato.freeshell.org>
In-Reply-To: <Pine.NEB.4.62.0605052040250.27826@ukato.freeshell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605052328.21370.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 22:44, Alexey Toptygin wrote:
> On Fri, 5 May 2006, Andi Kleen wrote:
> 
> > With your change there wouldn't be any sign extension and rw_verify_area
> > couldn't reject negative values them anymore.
> >
> > I think it would be a wrong change because it would differ from a native
> > 32bit kernel.
> 
> No...
> 
> On a 32 bit kernel (and on a 64 bit kernel using the native interface), 
> count is passed to sendfile as unsigned. rw_verify_area explicitly casts 
> to signed

To a 64bit signed.

> before checking for negativeness. The only place anywhere in the  
> kernel that count is signed (other than where rw_verify area explicitly 
> casts it for one test) is in the declaration of sys32_sendfile in the 
> x86_64 compat code. I'm pretty sure it's supposed to be unsigned there 
> too, and the current code is a typo.

It's a 32bit signed. 

Somehow the 32bit signed has to become a 64bit signed to be caught
by rw_verify_area(). The only place that can do that is the compat
layer.

-Andi
