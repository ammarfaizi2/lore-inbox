Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTLYVkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTLYVkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 16:40:39 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:55435 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264369AbTLYVki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 16:40:38 -0500
Message-ID: <3FEB5927.3040003@samwel.tk>
Date: Thu, 25 Dec 2003 22:39:51 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode for 2.6, version 4 + smart_spindown
References: <3FE92517.1000306@samwel.tk> <20031224111640.GL1601@suse.de> <3FE9AFFC.2080302@samwel.tk> <20031225100648.GB13382@conectiva.com.br> <3FEAFE66.2020602@samwel.tk> <200312251704.hBPH4QnO000128@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200312251704.hBPH4QnO000128@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Bradford wrote:
> No, but I've definitely seen other drives, (old Toshiba ~100 MB ones),
> which respect 'spin down immediately' commands, and don't support the
> spin down inactivity timer.  I can't remember whether they report
> Power Management feature set supported or not, though.

Hmmm, I think I've found the problem, hidden in the drive info. hdparm 
-I also says:

Capabilities:
[...]
         Standby timer values: spec'd by Standard, with device specific 
minimum

I think it's the device specific minimum that got me, -S 4 equals 20 
seconds, which is probably a lower value than the drive is capable of 
supporting. A bit nasty that the drive accepts the -S 4 setting, but 
just doesn't do anything with it. An error would have been nice. Anyway, 
the smart_spindown script does work for lower values, so I guess I'll 
use that instead. It has some added benefits as well, so I'm not too 
disappointed.

Bart

