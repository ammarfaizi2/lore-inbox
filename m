Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUHUJEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUHUJEn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHUJEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:04:43 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:62183 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S268920AbUHUJEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:04:41 -0400
Message-ID: <41271026.8030905@dgreaves.com>
Date: Sat, 21 Aug 2004 10:04:38 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, fsteiner-mail@bio.ifi.lmu.de,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	<4124BA10.6060602@bio.ifi.lmu.de>	<1092925942.28353.5.camel@localhost.localdomain>	<200408191800.56581.bzolnier@elka.pw.edu.pl>	<4124D042.nail85A1E3BQ6@burner>	<1092938348.28370.19.camel@localhost.localdomain>	<4125FFA2.nail8LD61HFT4@burner>	<101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>	<4126F27B.9010107@dgreaves.com> <20040821094955.3ab81037.Ballarin.Marc@gmx.de>
In-Reply-To: <20040821094955.3ab81037.Ballarin.Marc@gmx.de>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin wrote:

>On Sat, 21 Aug 2004 07:58:03 +0100
>David Greaves <david@dgreaves.com> wrote:
>
>  
>
>>Can someone explain why it isn't anyone with _write_ access to the
>>device? Surely it's better to drop a user into a group or setgid a
>>program?
>>
>>If I have write access to a device then I can wipe it's media anyway.
>>Is there something I'm missing?
>>
>>    
>>
>
>With RAW_IO access you cannot only wipe the media, but the entire
>firmware (not only wipe it, but also upload a malicious version that will
>screw up the entire SCSI or IDE bus).
>
>Andreas Messer and I are working on an improved filter that works per
>device and is configurable from userspace. It's not easy though.
>  
>
Thanks - I get that :)

The 'write' point is that from a data perspective you've already lost 
your data (which is the most valuable thing from a security perspective).
I agree it's nice to give people write access to hardware and not let 
them melt it permanently. However, if the semantics don't allow 'safe' 
writing then prevent all user writing and use setgid for safe programs 
(which is essentially what you are doing anyway) to allow users to write.

So, the real point: principle of least privilege.
Why root? why not set[gu]id cdwriters?

David
