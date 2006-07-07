Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWGGNyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWGGNyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGGNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:54:37 -0400
Received: from [195.23.16.24] ([195.23.16.24]:32175 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751207AbWGGNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:54:36 -0400
Message-ID: <44AE6799.7080705@grupopie.com>
Date: Fri, 07 Jul 2006 14:54:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, mtk-manpages@gmx.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice/tee bugs?
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de> <20060707131247.GX4188@suse.de> <20060707131403.GY4188@suse.de> <1152278514.3111.77.camel@laptopd505.fenrus.org> <20060707132651.GZ4188@suse.de>
In-Reply-To: <20060707132651.GZ4188@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jul 07 2006, Arjan van de Ven wrote:
>>> I cannot see where this could be happening, Ingo is this valid?
>> maybe the test found a way to exit the kernel previously while holding
>> the lock ?
> 
> I don't see how that could happen. The function in question is
> fs/splice.c:link_pipe(). There are no returns in that function, it
> always just breaks out and unlocks the two mutexes again.

AFAICS, in the case that you don't release any lock before entering 
pipe_wait (because of the lock ordering), pipe_wait just releases one of 
the locks and then schedules with the other lock still held.

BTW, the comment over the second pipe_wait was copy+pasted and is 
reversed ;)

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
