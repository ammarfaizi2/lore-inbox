Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVASUQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVASUQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVASUQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:16:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4741 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261867AbVASUP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:15:58 -0500
Date: Wed, 19 Jan 2005 11:25:18 -0800
From: Greg KH <greg@kroah.com>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: trz@us.ibm.com, karim@opersys.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org
Subject: Re: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
Message-ID: <20050119192518.GD2367@kroah.com>
References: <16872.19899.179380.51583@kix.watson.ibm.com> <20050114234817.GA6786@kroah.com> <16872.28149.139878.872756@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16872.28149.139878.872756@kix.watson.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 08:30:44PM -0500, Robert Wisniewski wrote:
> I believe the below illustrates the problem that will be seen without
> volatile.

Please read the lkml archives about all of the problems surrounding
marking variables "volatile" and how you really never want to do that in
the kernel.  If you want to access a variable in two different places,
at the same time, just use a lock to keep it sane.

>  > So these can just be removed, and the code changed to use the proper
>  > atomic calls?  If so, please do so.
> 
> Yes we can remove the code and use the standard atomic calls, but based on
> the above example, I think we need to mark a couple variables volatile.  Do
> you agree, if so, and unless there's dissenting opinion we can make the
> change.

No, I disagree.  Just use the standard atomic calls, they will work just
fine.

thanks,

greg k-h
