Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVERNfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVERNfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVERNfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:35:54 -0400
Received: from 174.10.79.83.cust.bluewin.ch ([83.79.10.174]:44665 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S262162AbVERNfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:35:48 -0400
Date: Wed, 18 May 2005 15:32:15 +0200
From: Karel Kulhavy <clock@twibright.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
Message-ID: <20050518133215.GB13736@kestrel>
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe> <20050517192412.GA19431@kestrel.twibright.com> <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu> <1116362191.32210.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116362191.32210.24.camel@mindpipe>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 04:36:30PM -0400, Lee Revell wrote:

[...]

> alsa-lib, which is part of userspace.  From the application's point of
> view, it does not matter whether the mixing happens in kernel or not.
> ALSA follows the philosophy of doing as little as possible in the
> kernel, and since mixing and volume control work fine in userspace,
> that's where they live.

Mixing is IMHO action that should be in kernel because

1) needs realtime scheduling to keep latency down
2) needs tight cooperation with the hardware to prevent dropouts
on underruns
3) Is a trivial linear algorithm involving memory blocks and linear
   arithmetic, no complicated computations that are difficult to
   check for BugFree(TM) so shouldn't present a great risk on kernel
   stability
4) Fits into the kernel philosophy. Kernel is a program meant to provide
   time-sharing access to limited hardware resource. Sound card is a
   limited hardware resource.
5) From the knowledge of the exact hardware, the mixing routine in
   kernel can know maximum allowable levels etc. to prevent clipping.
   

CL<
