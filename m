Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCOOcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCOOcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVCOOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:32:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46825 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261276AbVCOOca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:32:30 -0500
In-Reply-To: <20050315143412.0c60690a.sfr@canb.auug.org.au>
References: <20050315143412.0c60690a.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org>
Content-Transfer-Encoding: 7bit
Cc: Linus <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] PPC64 iSeries: cleanup viopath
Date: Tue, 15 Mar 2005 08:32:27 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 14, 2005, at 9:34 PM, Stephen Rothwell wrote:
>
> Since you brought this file to my attention, I figured I might as well 
> do
> some simple cleanups.  This patch does:
> 	- single bit int bitfields are a bit suspect and Anndrew pointed
> 	  out recently that they are probably slower to access than ints

> --- linus/arch/ppc64/kernel/viopath.c	2005-03-13 04:07:42.000000000 
> +1100
> +++ linus-cleanup.1/arch/ppc64/kernel/viopath.c	2005-03-15 
> 14:02:48.000000000 +1100
> @@ -56,8 +57,8 @@
>   * But this allows for other support in the future.
>   */
>  static struct viopathStatus {
> -	int isOpen:1;		/* Did we open the path?            */
> -	int isActive:1;		/* Do we have a mon msg outstanding */
> +	int isOpen;		/* Did we open the path?            */
> +	int isActive;		/* Do we have a mon msg outstanding */
>  	int users[VIO_MAX_SUBTYPES];
>  	HvLpInstanceId mSourceInst;
>  	HvLpInstanceId mTargetInst;

Why not use a byte instead of a full int (reordering the members for 
alignment)?

-- 
Hollis Blanchard
IBM Linux Technology Center

