Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJ1TEM>; Mon, 28 Oct 2002 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJ1TEM>; Mon, 28 Oct 2002 14:04:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19209 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261448AbSJ1TEL>;
	Mon, 28 Oct 2002 14:04:11 -0500
Message-ID: <3DBD8B6F.2070707@pobox.com>
Date: Mon, 28 Oct 2002 14:09:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, jdavid@farfalle.com
Subject: Re: [PATCH][2.5] 3c509 increase udelay in *read_eeprom
References: <Pine.LNX.4.44.0210281349350.1722-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>Hi Jeff,
>This is David's patch, find his reasoning and patch below.
>
>"... I had to set the udelay() call parameters to 2000 in  read_eeprom() 
>and 4000 in id_read_eeprom() to get the system to boot reliably with 2 
>3c509's in it. If I didn't set these values high enough, I got an oops 
>about 1/3 of the time when I booted....somehow (I'm guessing) it just 
>took the cards longer to initialize/respond when there were two of them 
>on the bus.
>
>I know the possibility of this (and the fix, setting the values higher) is 
>mentioned in Becker's 3c509 instructions, but I wanted to relay my 
>experience to you as well. Since AFAIK these subroutines are only called 
>at initialization time (we don't need to read the EEPROM after init), what 
>would be the harm of setting these values higher - at least 1000 for both, 
>say - in the standard driver? Certainly a millisecond or two means nothing 
>at boot time, and if it prevents even a few machines from mysteriously 
>oopsing when they're started, it's a win overall ..."
>  
>


lol... big udelays are almost always wrong.

First, long delays lock out everybody, thus you should do operations 
that require long waits via a timer or schedule_timeout() in process 
context.
Second, udelay of 1000 or greater is a bug, use mdelay() instead.


