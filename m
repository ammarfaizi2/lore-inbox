Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDMXG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDMXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWDMXG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:06:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWDMXG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:06:58 -0400
Date: Thu, 13 Apr 2006 16:06:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <1144969549.12387.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604131603310.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> 
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au> 
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>  <1144965022.12387.23.camel@localhost.localdomain>
  <Pine.LNX.4.64.0604131531440.3701@g5.osdl.org> <1144969549.12387.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Apr 2006, Alan Cox wrote:
> 
> Quality for whom ? There is a measurable cost to all that extra locking
> which will hurt everyone. Given existing kernels don't make the
> guarantee and SuS v3 does not make the guarantee the apps that need it
> will continue to do the extra work themselves anyway.

True. 

> And of course I too would like to know if anyone is hitting O_APPEND
> examples of this problem and if so on what fs ....

Well, Dan already said that he doesn't see it with O_APPEND (aka ">>"), 
but yes, other filesystems may not be that lucky.

I'd actually not be surprised if the O_APPEND thing is tested by some of 
the FS stress tools, so I suspect all the regular filesystems get it 
right. Of course, since most of them - at least the local ones - use the 
same generic framework, that's an even safer bet.

NFS etc is very special, of course, especially in the presense of clients 
on different machines. At that point, I wouldn't guarantee a whole lot.

		Linus
