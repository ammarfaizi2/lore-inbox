Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUGBCzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUGBCzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 22:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUGBCzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 22:55:22 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:20383 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266391AbUGBCzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 22:55:07 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Date: Thu, 1 Jul 2004 21:54:16 -0500
User-Agent: KMail/1.5.4
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200407011035.13283.kevcorry@us.ibm.com> <20040701143857.256959e5.akpm@osdl.org>
In-Reply-To: <20040701143857.256959e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407012154.16312.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 16:38, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> > Remove the limitation of 1024 DM devices.
>
> That seems to be an awful lot of fuss just to maintain a bitmap.

Mmm...perhaps.

> What is a realistic useful upper bound on the minors?  Would it not be
> sufficient to increase the size of the statically allocated bitmap?

I guess that depends on who you ask. Obviously, for most people the previous 
limit of 1024 devices is more than enough. But there's always going to be 
folks pushing the limits. So I figured I'd go ahead and rewrite it to 
theoretically allow for the maximum range of minor numbers, while trying not 
to waste memory for the common case.

> Did you consider going to a different data structure altogether? 
> lib/radix-tree.c and lib/idr.c provide appropriate ones.

The idr stuff looks promising at first glance. I'll take a better look at it 
tomorrow and see if we can switch from a bit-set to one of these data 
structures.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net

