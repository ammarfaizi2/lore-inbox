Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268209AbTCFT0J>; Thu, 6 Mar 2003 14:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbTCFT0J>; Thu, 6 Mar 2003 14:26:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13074 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268209AbTCFT0H>; Thu, 6 Mar 2003 14:26:07 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Oops in 2.5.64
Date: Thu, 6 Mar 2003 19:36:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b487vc$1u6$1@penguin.transmeta.com>
References: <3E66E782.5010502@tmsusa.com>
X-Trace: palladium.transmeta.com 1046979379 4453 127.0.0.1 (6 Mar 2003 19:36:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Mar 2003 19:36:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E66E782.5010502@tmsusa.com>, J Sloan  <joe@tmsusa.com> wrote:
>
>2.5.64 was running well, but after a day
>or so of uptime, in fairly busy use (squid,
>postfix, dhcp server, iptables, X desktop)
>I ssh'd in as root, issued an init 3, then
>a moment later, init 5. A moment after
>that, the ssh session froze and all internet
>access stopped as well.
>
>The console was frozen, with an oops -

Are you using DRI? There is some evidence that exiting and restarting X
will not correctly re-initialize the DRI stuff in the kernel, and
_massive_ kernel memory corruption can ensure when the new X server
starts. 

At which point you'll get random oopses etc.

	>CONFIG_AGP=y
	># CONFIG_AGP3 is not set
	>CONFIG_AGP_INTEL=y
	># CONFIG_AGP_VIA is not set
	># CONFIG_AGP_AMD is not set
	># CONFIG_AGP_SIS is not set
	># CONFIG_AGP_ALI is not set
	># CONFIG_AGP_SWORKS is not set
	># CONFIG_AGP_AMD_8151 is not set
	>CONFIG_DRM=y
	>CONFIG_DRM_TDFX=m
	>CONFIG_DRM_R128=m
	># CONFIG_DRM_RADEON is not set
	>CONFIG_DRM_I810=y
	># CONFIG_DRM_I830 is not set
	># CONFIG_DRM_MGA is not set

Looks like you at least have the DRI kernel modules there.

Try to see if the problem goes away if you start X without DRI support
(ie remove the "Load 'dri'" or whatever from the XF86Config file, or
start up in a mode that DRI doesn't support, like 8bpp).

		Linus

