Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbXASIr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbXASIr0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 03:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbXASIr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 03:47:26 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40861 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964972AbXASIr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 03:47:26 -0500
Message-ID: <45B085AA.70109@drzeus.cx>
Date: Fri, 19 Jan 2007 09:47:38 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmc: correct semantics of the mmc_host_remove
References: <20070119015037.8318.qmail@web36709.mail.mud.yahoo.com>
In-Reply-To: <20070119015037.8318.qmail@web36709.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> Greetings.
>
> It appears to me that under certain circumstances mmc layer will issue requests to the host after
> mmc_host_remove returns. This happens, for example, in tifm_sd driver because mmc_host may be
> removed mid-transfer, as the socket shall be freed for possible reuse by different media type.
> Currently, the only solution is to sleep a little somewhere after mmc_remove_host but before
> mmc_free_host. I think the correct way to handle the situation is to ensure that mmc_host is never
> accessed by the mmc layer after mmc_remove_host returns.
>
>   

That shouldn't be possible. Are you using the block queue fixes I wrote?
Otherwise you will get problems like this.

Basically, when you call mmc_host_remove(), it will remove all card
devices. That shouldn't complete until all card drivers have released
control of the card. At that point there is no one else accessing the
device. If you see something else, then we have a bug somewhere.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

