Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCQVZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCQVZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCQVZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:25:15 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:40824 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261193AbVCQVZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RFzN51i1ZL3iRVRz4WsLr90/SDoX6FrNFusYI7Icwzmp6YzfbyMeM7s70oosG2OCv9iNJYz7eOjeCTJDIwhK3ku/EyHIYkJVOV2DDh8t0QnjMbsadslmm/GCgHy6VRsfhfveIIfsYbyfBEjEw38aKGxrD3Fja3+ccYhcQoJ/Jko=
Message-ID: <2cd57c90050317132570147e7c@mail.gmail.com>
Date: Fri, 18 Mar 2005 05:25:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: oom with 2.6.11
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4238DD01.9060500@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <422DC2F1.7020802@g-house.de>
	 <2cd57c9005031102595dfe78e6@mail.gmail.com>
	 <4231B4E9.3080005@g-house.de> <42332F9C.7090703@g-house.de>
	 <4238DD01.9060500@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 02:27:29 +0100, Christian Kujau <evil@g-house.de> wrote:
> hello again,
> 
> unfortunately i've hit OOM again, this time with "#define DEBUG" enabled
> in mm/oom_kill.c:
> 
> http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.3.txt
> 
> by "Mar 16 18:32" pppd died again and OOM kicked in 30min later.
> (there are a *lot* messages of a shell script named "check-route.sh". it's
> a little script which runs every minute or so to check if my default route
> is still ok and if ping to the outside world are possible. definitely not
> a memory hog, but noisy)


I do "grep check-route.sh oom_2.6.11.3.txt | wc" and it shows 4365
lines, which means
there're 4365 that script processes running, from pid 4260 to12747,
mostly with pretty low points, 123.  Based on this points, suppose
each script consumes 100k, that'll be 100k*4k=400M roughly. And your
box's is merely 256M MemTotal.

The currently oom algorithm fails to find out such kinds of memory hog.
And the kernel kills other innocent processes because the its points
is much lower than most others.

Check this script and disable it; see what will happen.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
