Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTCDUvy>; Tue, 4 Mar 2003 15:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTCDUvy>; Tue, 4 Mar 2003 15:51:54 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:53718 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266939AbTCDUvx>;
	Tue, 4 Mar 2003 15:51:53 -0500
Message-ID: <3E651456.1050808@colorfullife.com>
Date: Tue, 04 Mar 2003 22:02:14 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: no_spam@ntlworld.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kill_fasync usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SA wrote:

>I wnat to use kill_fasync(struct fasync_struct *PTR,...) to notify userland of 
>events.  Can I just call kill_fasync regardless of the state of PTR or does 
>PTR actually have to point to something valid.  
>  
>
kill_fasync receives the _address_ of the variable that contains the 
list of processes that need notifications. It must not be NULL. (I 
assume you look at 2.4 or 2.5 - 2.2 had a different interface)

Check linux/drivers/char/busmouse.c for an example, the interface is 
simple: call fasync_helper to register and kill_fasync for the actual 
notification.

--
    Manfred

