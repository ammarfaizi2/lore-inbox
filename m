Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJ2TfQ>; Tue, 29 Oct 2002 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSJ2Tes>; Tue, 29 Oct 2002 14:34:48 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:30190 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262215AbSJ2Tbm>; Tue, 29 Oct 2002 14:31:42 -0500
Message-ID: <3DBEE1CE.2060200@nortelnetworks.com>
Date: Tue, 29 Oct 2002 14:30:22 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: Paul.Clements@steeleye.com, Khalid Aziz <khalid@fc.hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
References: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com> <3DBED111.96A3A1E8@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz wrote:
> Paul Clements wrote:
> 
>>Have you considered compressing the config info in order to reduce
>>the space wastage in the loaded kernel image? Could easily be 10's of KB
>>(not that that's a lot these days). The info would then be retrieved via
>>"gunzip -c", et al. instead of a simple "cat".
>>
> 
> I wanted to start with a simple implementation first. There are a couple
> of things that can be done in future to further improve meory usage: (1)
> Drop "CONFIG_" and "# CONFIG_" from each line and add it back when
> printing from /proc/ikconfig and extract-ikconfig script, (2) Compress
> the resulting configuration. Something to do in near future :)

Do we really need to store the ones that are not actually set to 
something?  You'll get a bunch of queries when doing a "make oldconfig", 
but saying N to all of them should just work...after all its the ones 
that are actually *set* that we care about.

Also, if you wanted to get cute, you could make use of the fact that the 
config names only use ascii chars from '0' to 'Z' which can be 
represented by 6 bits, then pack them together in memory.  I don't know 
how much difference this would make after zipping though.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

