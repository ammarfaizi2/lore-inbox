Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUETLS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUETLS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 07:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUETLS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 07:18:59 -0400
Received: from [195.23.16.24] ([195.23.16.24]:38277 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263163AbUETLSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 07:18:55 -0400
Message-ID: <40AC947E.2050706@grupopie.com>
Date: Thu, 20 May 2004 12:20:30 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Dynamic fan clock divider changes (long)
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
In-Reply-To: <20040516222809.2c3d1ea2.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.3; VDF: 6.25.0.73; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> The user still doesn't have to care, which is fine, but if the user has
> a fan speed between 2000 and 5000 RPM, with low limit set to 1500 RPM,
> he/she will have a "bad" accuracy at 5000 RPM (+/- 104 RPM). I see this
> as the low limit "nailing" the divider ;)

This doesn't sound so bad at all. And this seems to be the simplest approach.

> This is what I implemented in my new pc87360 driver (after trying #1). I
> use 85 and 224 as the arbitrary limits for changing dividers.

This confused me a bit. It seems that a direct consequence of implementation #2 
is that the divider will be set in a way that the low limit will be between 128 
and 255, and that there is no point in changing the divider, because it will 
only get worse. This leads directly to implementation #4. Am I missing something?

Anyway, if the user is really concerned about accuracy an average of several 
measurements should increase precision in this kind of problem. See the 
following ascii art:

clock:
     ___     ___     ___     ___     ___     ___     ___     ___
___|   |___|   |___|   |___|   |___|   |___|   |___|   |___|   |__

fan complete turn pulse:

____________________|_____________________|_____________________|

So the first measurement is 3 (assuming rising edge counting), but some of the 
period will slip into the second measurement giving a count of only 2, and so 
on. So the jitter on the counts is actually correlated with the fan speed.

Just my 2 cents,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
