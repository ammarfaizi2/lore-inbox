Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWAFBbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWAFBbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWAFBbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:31:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932455AbWAFBbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:31:36 -0500
Date: Thu, 5 Jan 2006 17:30:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 4/6] sysctl: dont overflow the user-supplied buffer with
 0
In-Reply-To: <20060106004555.GD25207@sorel.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
 <20060106004555.GD25207@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Chris Wright wrote:
> 
> If the string was too long to fit in the user-supplied buffer,
> the sysctl layer would zero-terminate it by writing past the
> end of the buffer. Don't do that.

Don't use this one. It doesn't zero-pad the string if the result buffer is 
too small (which _could_ cause problems) and it actually returns the wrong 
length too. 

There's a better one in the final 2.6.15.

			Linus
