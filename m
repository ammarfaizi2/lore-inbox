Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWFYSVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFYSVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFYSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:21:51 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:2976 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932085AbWFYSVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:21:50 -0400
Date: Sun, 25 Jun 2006 20:21:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
Message-ID: <20060625182147.GA17945@mars.ravnborg.org>
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 01:40:49PM -0400, Jon Smirl wrote:
> In Kconfig all of the radio cards depend on VIDEO_V4L1. But V4L1 has
> been deprecated and replaced with V4L2. V4L2 offers a V4L1
> compatibility layer. Should the Kconfig for these devices be changed
> to depend on (VIDEO_V4L1. || VIDEO_V4L1_COMPAT)? I'm not the
> maintainer for this but they seem to build ok.

A cleaner approach would be to define a local symbol that spelled out
the dependencies. Something like

# Used because ....
config RADIO
	depends on ISA && (VIDEO_V4L1 || VIDEO_V4L1_COMPAT)

config RADIO_CADET
	tristate "ADS Cadet AM/FM Tuner"
	depends on RADIO

The variable name RADIO is awfully bad but you get the idea..

	Sam
