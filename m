Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTIEDVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTIEDVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:21:34 -0400
Received: from waste.org ([209.173.204.2]:24265 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261861AbTIEDVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:21:32 -0400
Date: Thu, 4 Sep 2003 22:21:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add_mouse_randomness
Message-ID: <20030905032124.GL31897@waste.org>
References: <UTC200309042251.h84MpsX07601.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200309042251.h84MpsX07601.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 12:51:54AM +0200, Andries.Brouwer@cwi.nl wrote:
> I do not know whether anybody cares, but the random driver
> is a little bit broken these days.
> 
> Long ago:
> Keystrokes cause randomness added via add_keyboard_randomness.
> Mouse movements cause randomness added via add_mouse_randomness.
> Key repeat does not add randomness.
> 
> Today:
> Every keypress and every key release causes two calls of
> add_mouse_randomness and one call of add_keyboard_randomness.
> Key repeat causes lots of calls of add_mouse_randomness.
> 
> The random driver contains a mechanism (delta, delta2, delta3)
> for estimating the amount of entropy in a stream of moments in
> time. But the fact that every event causes two calls, very
> quickly after each other, poisons this mechanism, and makes us
> overestimate.

The real problem is that the deltas are calculated from gigahertz
cycle counters, but yes, we're calling too frequently and blowing away
useful history. I've experimented with making the deltas per-source as
well.

I'll put this on my todo list.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
