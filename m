Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJAEJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTJAEJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:09:06 -0400
Received: from dyn-ctb-203-221-73-105.webone.com.au ([203.221.73.105]:38917
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261898AbTJAEI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:08:56 -0400
Message-ID: <3F7A534B.3020401@cyberone.com.au>
Date: Wed, 01 Oct 2003 14:08:43 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Murray J. Root" <murrayr@brain.org>
CC: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test6 scheduling(?) oddness
References: <20031001032238.GB1416@Master>
In-Reply-To: <20031001032238.GB1416@Master>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Murray J. Root wrote:

>P4 2G
>1G PC2700 RAM
>ASUS P4S533 
>
>Large tasks (like raytrace rendering) take double the amount of time they used
>to take, although the system is nicer to the user while they run. In 
>2.6.0-test5 had a little trouble with it and Piggin pointed me to a patch that
>fixed it and is now in -test6, however the patch didn't slow the rendering as
>much as it does in test6. (Con Koliva's patch, I believe it was).
>For example - rendering an image that took 15 minutes in 2.5.65 takes 20 
>minutes in 2.6.0-test5 (with patch) and 30 minutes in 2.6.0-test6 (raw from
>kernel.org). Same config options (everything I use builtin - no modules).
>
>A new issue (which also doesn't happen in -test5 with the patch):
>When running cpu intense tasks, new (large) tasks will not start till the first
>one finishes.
>For example, using POV-Ray 3.5 to render an image that takes 30 minutes when it
>is the only program running, start oowriter.
>The render finishes in the same 30 minutes, then oowriter starts.
>oowriter takes about 3 seconds to load if no rendering is going on.
>I can use apps that are already open but can't start new ones while rendering.
>In 2.6.0-test5 (with patch) opening oowriter while rendering takes about 1 
>minute.
>In 2.5.65 opening oowriter while rendering takes about 2 minutes (and X gets
>very hard to use till oowriter is completely done opening).
>

Hi Murray!
Con Kolivas' patch has been included in test6. You might have tried that
or maybe my patch?

Anyway, lets just clarify your report:
1 CPU, hyperthreading on or off?

test5 interactivity under load isn't as good as test6.

povray takes 150% more time in test6 vs tset5. How many compute threads
does povray use? Is anything else running?

oowriter takes 3 seconds to load when nothing is running
oowriter takes 30(or more) minutes to load when povray is runnnig, takes
1 minute in test5 plus patch (could you tell us exactly what the patch
is)


