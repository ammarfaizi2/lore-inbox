Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUILLTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUILLTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUILLTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:19:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20133 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268665AbUILLTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:19:48 -0400
Date: Sun, 12 Sep 2004 13:20:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912112026.GA16678@elte.hu>
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu> <20040912104314.GN2660@holomorphy.com> <20040912104524.GO2660@holomorphy.com> <20040912110810.GQ2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912110810.GQ2660@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> Forgot to check map->page in the first spin:
> 
> last_pid is not honored because next_free_map(map - 1, ...) may return
> the same map and so restart with a lesser offset.

it's getting quite spaghetti ... do we really want to handle
RESERVED_PID? There's no guarantee that any root daemon wont stray out
of the 1...300 PID range anyway, so if it has an exploitable PID race
bug then it's probably exploitable even without the RESERVED_PID
protection.

	Ingo
