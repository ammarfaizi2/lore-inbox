Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTIERFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTIERFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:05:54 -0400
Received: from waste.org ([209.173.204.2]:34999 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265464AbTIERFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:05:53 -0400
Date: Fri, 5 Sep 2003 12:05:29 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add_mouse_randomness
Message-ID: <20030905170529.GM31897@waste.org>
References: <UTC200309050916.h859G5813732.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200309050916.h859G5813732.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 11:16:05AM +0200, Andries.Brouwer@cwi.nl wrote:
>     From oxymoron@waste.org  Fri Sep  5 07:01:30 2003
>     From: Matt Mackall <mpm@selenic.com>
> 
>     > Today:
>     > Every keypress and every key release causes two calls of
>     > add_mouse_randomness and one call of add_keyboard_randomness.
>     > Key repeat causes lots of calls of add_mouse_randomness.
>     > 
>     > The random driver contains a mechanism (delta, delta2, delta3)
>     > for estimating the amount of entropy in a stream of moments in
>     > time. But the fact that every event causes two calls, very
>     > quickly after each other, poisons this mechanism, and makes us
>     > overestimate.
> 
>     The real problem is that the deltas are calculated from gigahertz
>     cycle counters, but yes, we're calling too frequently and blowing away
>     useful history. I've experimented with making the deltas per-source as
>     well.
> 
> I wouldnt know what is wrong with using gigahertz cycle counters.
> The deltas are already per-source.

Actually, they're only per-class. So if you have multiple mice,
keyboards, drives, etc., they interfere with each other's deltas and
increase the entropy estimates overall.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
