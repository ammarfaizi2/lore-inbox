Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWITHnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWITHnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWITHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:43:01 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:63466 "EHLO
	fbxmetz.linbox.com") by vger.kernel.org with ESMTP id S1751268AbWITHnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:43:00 -0400
Message-ID: <4510F0FD.4060602@linbox.com>
Date: Wed, 20 Sep 2006 09:42:53 +0200
From: Ludovic Drolez <ldrolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: linux-kernel@vger.kernel.org, subdino2004@yahoo.fr
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
References: <200609031541.39984.subdino2004@yahoo.fr>	 <200609031910.57259.vincent.plr@wanadoo.fr>	 <200609070130.53995.vincent.plr@wanadoo.fr>	 <loom.20060919T155900-330@post.gmane.org> <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com>
In-Reply-To: <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> A variant on this theme would be (not tested or somewhat, just a
> random idea for considering):
> 
> 1. find if the process is a cpu-hog, if not then ignore
> 
> 2. find somehow how much time has this process on it's current cpu
> 
> 3. then, instead of always substracting 1 from th current load on the
> current cpu, substract for example 1...0 when running from 0 to 60
> seconds... this way cpu hogs would only rotate slowly?
> 
> in code:
> 
> number_to_sub_from_queue_load = (256 - min(256,
> time_from_last_change_of_cpu)) >> 8;
> 
> somehow managing to get fixedpoint loadlevels on the runqueues would
> make this work better....
> 

Yes ! That might be a better idea !
In fact, I tested the 1st patch on our cluster (Finite elements computing on 8 
CPUs):
- Under Windows: 875 seconds
- Linux 2.6.16 : 1019 s
- Linux 2.6.16 + manual taskset : 842 s
- Linux 2.6.16 + Vincent's patch : 1373 s  :-(

If you find time to write a patch, Antonio, I would be pleased to try it !

Cheers,

-- 
Ludovic DROLEZ
http://lrs.linbox.org - Free asset management software
