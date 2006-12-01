Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936067AbWLAHxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936067AbWLAHxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936072AbWLAHxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:53:32 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:37525 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S936067AbWLAHxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:53:31 -0500
Date: Fri, 1 Dec 2006 16:53:12 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avr32: Fixup kprobes preemption handling.
Message-ID: <20061201075312.GA30434@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-kernel@vger.kernel.org
References: <20061201075050.GA30051@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201075050.GA30051@linux-sh.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 04:50:50PM +0900, Paul Mundt wrote:
> While working on SH kprobes, I noticed that avr32 got the preemption
> handling wrong in the no probe case. The idea is that upon entry of
> kprobe_handler() preemption is disabled outright across the life of the
> kprobe, only to be re-enabled in post_kprobe_handler().
> 
> However, in the event that the probe is never activated, there's never
> any chance of hitting the post probe handler, which allows for the
> current avr32 implementation to disable preemption indefinitely, as it's
> currently missing a re-enable when no probe is activated.
> 
> Patch follows.
> 
And that's of course..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
