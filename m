Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272239AbTHDWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272243AbTHDWQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:16:57 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13828 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272239AbTHDWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:16:43 -0400
Subject: Re: [PATCH] O13int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308050746.29140.kernel@kolivas.org>
References: <200307280112.16043.kernel@kolivas.org>
	 <1060023104.889.7.camel@teapot.felipe-alfaro.com>
	 <1060023516.511.0.camel@teapot.felipe-alfaro.com>
	 <200308050746.29140.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060035393.511.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Aug 2003 00:16:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-04 at 23:46, Con Kolivas wrote:
> On Tue, 5 Aug 2003 04:58, Felipe Alfaro Solana wrote:
> > OK, I had the X server reniced at -20... Renicing the X server at +0
> > makes the XMMS skips disappear. At least, with X at +0 I've been able to
> > reproduce them anymore.
> 
> As always, thanks Felipe.

It's great to be helpful.

> This is good news. X should be able to make xmms skip if it's -20, and X 
> should still be smooth at 0. 

X is pretty smooth, but at certain times, it feels somewhat "jumpy".
When X is under load (not a single cpu hogger, like my standard devil
while loop), the mouse cursor is jumpy and X gets CPU at bursts.
Renicing X to -20 seemed to help in those situations, but caused XMMS to
skip, so I'm not pretty sure what's better. Meanwhile, I've reniced X
back to +0 to try to reduce those skips.

At nice +0, I can reproduce X "jumpiness" by opening several instances
of Konqueror, loading some web pages from http://www.linuxtoday.com, for
example and then arrange them all "tiled" (more or less tiled is
perfect, too) on the screen. Then, I drag a window over them as fast as
I can, then as slow as I can. This causes a lot of repainting, increases
CPU usage and, instead of concentrating all the CPU usage on a single
process (like the devil while loop), the load is distributed among all
the Konqueror processes. That makes X to not feel smooth, but jumpy.

Evolution is another kind of application that requires kinda lot of CPU
power when requested to do repainting. Many times, forcing Evolution to
repaint itself, by moving a window over it, generates a lot of "uncover"
events. Sometimes, Evolution feels pretty smooth, and other times, the
window I'm dragging over Evolution starts moving not so smoothly.

But anyway, I still feels this is getting on the right track. I think
it's a matter of time and a little tuning, but this will rock in the
end.

