Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCUU1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCUU1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:27:07 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:36242 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261232AbUCUU06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:26:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Mar 2004 12:26:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <20040321181430.GB29440@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0403211159320.12699-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Jörn Engel wrote:

> On Sun, 21 March 2004 09:59:39 -0800, Davide Libenzi wrote:
> > 
> > When I did that, fumes of an in-kernel implementation invaded my head for 
> > a little while. Then you start thinking that you have to teach apps of new 
> > open(2) semantics, you have to bloat kernel code a little bit and you have 
> > to deal with a new set of errors cases that open(2) is not expected to 
> > deal with. A fully userspace implementation did fit my needs at that time, 
> > even if the LD_PRELOAD trick might break if weak aliases setup for open 
> > functions change inside glibc.
> 
> 209 fairly simple lines definitely have more appear than a full
> in-kernel implementation with many new corner-cases, yes.  But it
> looks as if you ignore the -ENOSPC case, so you cheated a little. ;)

Yes, at that time I preferred to fall back to the caller open(2) if any 
error happened during the COW (a more picky implementation would simply 
bounce an error to the application). Look BTW that there is a difference 
between the error handling when you have an in-kernel solution or a 
completely userspace solution. If you push this inside the kernel you have 
at least to define a new open(2) flag and a new set of errors that might 
arise when doing the COW. You are basically changing the open(2) API. You 
have also to "teach" apps to use the new flag, since obviously you cannot 
make COW a default behavior. The fl-cow approach let you define a set of 
paths where you want COW to happen (in my case typically /usr/src/lk), and 
only apps writing to hard-linked files inside such path gets COWed. The 
open(2) API does not change. OTOH there is the LD_PRELOAD trick that is 
weak alias dependent.



- Davide



