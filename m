Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbULNBWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbULNBWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNBTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:19:52 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:59910 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbULNBO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:14:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TjK79wN+N/yDHAsRkmPYafvovaxvuZp+dHXFNuFz58UqPnlQlCU8nFw91fA68ahCrJSKiAfTIqU0zLuzIRyuTi3pm7z1iSEDHhP/hFTwNbnhlgE7NXhB7OF8KMRgkqVt78GFuKrBeDA88k1FSHrQGx1vklIwgQjHST+MsG5BjQk=
Message-ID: <a36005b504121317145f144cd1@mail.gmail.com>
Date: Mon, 13 Dec 2004 17:14:56 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Kalaky <kalaky@gmail.com>
Subject: Re: [RFC] sigpending rework
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4de0ceaa04121315064b9643c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4de0ceaa04121315064b9643c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 21:06:08 -0200, Kalaky <kalaky@gmail.com> wrote:
 
> 
> I'm working on converting the sigpending structure into a vector
> of _NSIG sigqueue's for each signal number (which is quite a big
> work), this way we can directly access each signal list, delivering
> and checking any pending signals in a efficient manner.

This looks like a logical extension but the question is, is it worth
it?  I don't know about a case so far where this is a bottle neck. 
But any solution will cost every process, regardless of whether it
uses signals often or not.

So, if your solution can avoid or keep the cost very very low, it
might be worth using such a change.  Otherwise the ol' saying applies:
avoid signals at all costs.
