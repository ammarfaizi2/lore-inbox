Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUFFJ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUFFJ6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUFFJ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:58:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:24960 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S263191AbUFFJ6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:58:34 -0400
Date: Sun, 6 Jun 2004 11:58:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Message-ID: <20040606095843.GC1646@ucw.cz>
References: <200406050249.02523.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406050249.02523.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 02:49:00AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Currently mousedev combines all hardware motion data that arrivers since
> last time userspace read data into one cooked PS/2 packet. The problem is
> that under heavy or even moderate load, when userspace can't read data
> quickly enough, we start loosing valuable data which manifests in:
> 
> - ignoring buton presses as by the time userspace gets to read the data
>   button has already been released;
> - click starts in wrong place - by the time userspace got aroungd and read
>   the packet mouse moved half way across the screen.
> 
> The patch below corrects the issue - it will start accumulating new packet
> every time userspace is behind and button set changes. Size of the buffer
> is 16 packets, i.e. up to 8 pairs of press/release events which should be
> more than enough.
> 
> The patch is against Vojtech's tree and shuld apply to -mm. I also have
> cumulative mousedev patch done against 2.6.7-pre2 at:
> 
> http://www.geocities.com/dt_or/input/misc/mousedev-2.6.7-rc2-cumulative.patch.gz

Thanks for this. Can I just pull from your tree, or is there more that I
shouldn't take?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
