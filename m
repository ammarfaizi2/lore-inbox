Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUBMIMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUBMIMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:12:51 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1152 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266817AbUBMIL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:11:59 -0500
Date: Fri, 13 Feb 2004 09:12:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Robert White <rwhite@casabyte.com>
Cc: "'Marko Macek'" <Marko.Macek@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse problem with KVM switch
Message-ID: <20040213081231.GA247@ucw.cz>
References: <402602B9.1090005@gmx.net> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 02:29:24PM -0800, Robert White wrote:

> Less than optimal, yes, but technologically sound.  Since there is no "soft
> reset" behavior provided by the PS/2 standard, let alone any way for the KVM
> switch to signal the driver that such logic needs to be invoked in software,
> the real truth of the issue is that this is a limitation inherent in the
> design of the PS/2 interface and any solution other than
> greatest-common-denominator will be unstable.
> 
> It would have been better if the PS/2 (and keyboard) interface were designed
> with hot-plugability in mind and the KVM switch did nothing but detach the
> devices so that a "switch to" even caused the software to rediscover the
> device and reset the parameters.  The thing was that part of the core
> purpose of the KVM today was designed to prevent the old "keyboard not
> found, press F1 to continue booting" nonsense... Thank You Pane/Webber. 8-)
> 
> Rob.
> 

Sadly enough, there is a soft reset command in the PS/2 protocol, and
the PS/2 interface is designed for hotplug, and because of that Linux
2.6 can easily handle hotplugging of both PS/2 keyboards and mice,
including type detection, etc, BUT the KVM switches don't use that,
because Windows historically doesn't support unplugging a PS/2 mouse.

The most ugly part of the KVM switch in this play is that while the KVM
switch usually implements a virtual mouse for each of the machines, it
lets them all talk to the real one, and if they have different ideas
about what mode the mouse should be set to, well, then there goes the
road to madness.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
