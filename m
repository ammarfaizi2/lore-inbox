Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271919AbTHROly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271922AbTHROly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:41:54 -0400
Received: from holomorphy.com ([66.224.33.161]:26854 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271919AbTHROlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:41:53 -0400
Date: Mon, 18 Aug 2003 07:43:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Max Hailperin <max@gustavus.edu>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Message-ID: <20030818144301.GW32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Max Hailperin <max@gustavus.edu>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <20030818110001.6564.64238.Mailman@lists.us.dell.com> <200308181252.h7ICqZh8003767@mccormic.mcs.gac.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308181252.h7ICqZh8003767@mccormic.mcs.gac.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <kernel@kolivas.org>
>    ... I do have some ideas about how to progress with this (some Mike
>    has suggested to me previously), but so far most of them involve
>    some detriment to the interactive performance on other apps. So I'm
>    appealing to others for ideas.

On Mon, Aug 18, 2003 at 07:52:35AM -0500, Max Hailperin wrote:
> I suggest you put a small limit on the number of times that a task can
> be requeued onto the active array before it needs to go to the expired
> array.  -max

Well, first off this undoes the effect of code already in place (the
interactivity heuristics), and second it's defeated by high arrival
rates spread across many tasks. The second is fatal but there isn't
much that can be done about it in the current design, and I don't
have enough subtlety to see how to fiddle with the bits necessary to
recover anything out of the first. AFAICT no fixed limit will ever
do; any given limit will be too many for some tasks and not enough
for others, and there's no way to guess based on the task (if what said
it was interactive was enough in the first place, you wouldn't have to
resort to this), so you've been hanged just for trying.

-- wli
