Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161413AbWBUH2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161413AbWBUH2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWBUH2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:28:41 -0500
Received: from iabervon.org ([66.92.72.58]:40964 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161413AbWBUH2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:28:40 -0500
Date: Tue, 21 Feb 2006 02:29:12 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
In-Reply-To: <20060221014824.GA19998@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.64.0602210149190.6773@iabervon.org>
References: <20060221014824.GA19998@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Herbert Poetzl wrote:

> Hi Sam! Folks!
> 
> recently had the idea to utilize cpp or sparse to
> do some automated #include checking, and I came up
> with the following proof of concept:
> 
> I just replaced the sparse binary by the following
> script (basically hijacking the make C=1 system)
> 
> it would allow kernel developers to easily identify
> duplicate includes, which in turn, might reduce
> dependancies and thus build time ...

I think the kernel style is to encourage duplicate includes, rather than 
removing them. Removing duplicate includes won't remove any dependancies 
(since the includes that they duplicate will remain). And it makes it 
harder to remove unnecessary includes (which does reduce dependancies), 
because when header A stops needing header B, various other code could 
expect that including header A means they get header B, and these places 
have to be found and the formerly-duplicate include put back. So you 
actually do best to have lots of duplicate includes and aggressively prune 
unnecessary includes.

	-Daniel
*This .sig left intentionally blank*
