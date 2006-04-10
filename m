Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWDJXJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWDJXJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDJXJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:09:34 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:30627 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932183AbWDJXJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:09:33 -0400
Message-ID: <443AE603.5070509@keyaccess.nl>
Date: Tue, 11 Apr 2006 01:10:59 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [Alsa-devel] Re: [ALSA 1/2] continue on IS_ERR from platform
 device registration
References: <44347822.9050206@keyaccess.nl>	<s5h3bgqlcfd.wl%tiwai@suse.de>	<443692B2.7000309@keyaccess.nl> <s5hacat49y3.wl%tiwai@suse.de>
In-Reply-To: <s5hacat49y3.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

> Hm, surely it's not so intuitive in the case of ISA devices.  Maybe 
> it'd be better to keep the current behavior:  probe() returns an
> error if no device is found at loading...

Okay. It's always possible to revisit the isssue later. Keeping the old
behaviour is what the already submitted patches did. probe() returning
an error is not enough; the issue was/is that that error is not
being passed up. Using drvdata as a private success flag as submitted
works fine fortunately; all drivers do a platform_set_drvdata(device,
card) just before returning success from probe().

I'll repost them following this message. Have been generated against
2.6.17-rc1-mm2.

Will also post them (and the !enable[i] patch) against 2.6.16.2 for
-stable. You already acked the !enable[i] and continue-on-is_err patches
for -stable, the third is the same unregister patch, restoring the old
fail-to-load behaviour also for -stable.

Considering that one of the rules for -stable is that fixes also need to 
be present in upstream trees, could you relay the three patches for 
-stable yourself?

Rene.


