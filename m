Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbSJIXJn>; Wed, 9 Oct 2002 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262359AbSJIXJn>; Wed, 9 Oct 2002 19:09:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58380 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262189AbSJIXJl>; Wed, 9 Oct 2002 19:09:41 -0400
Date: Wed, 9 Oct 2002 16:17:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() atomicity fix
In-Reply-To: <1034204745.794.206.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0210091615540.9234-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Oct 2002, Robert Love wrote:
> 
> Anyhow, attached patch fixes the atomicity debugging error.

I don't think this is right. You have to be preempt safe over the whole 
time you're holding the "rq" pointer, I think. Otherwise you might move to 
another CPU, at which point the rq state isn't valid any more. Or maybe I 
misunderstood.

		Linus

