Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272747AbTG1JHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272749AbTG1JHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:07:08 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:64529 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S272747AbTG1JHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:07:04 -0400
Message-Id: <200307280912.h6S9CWj28217@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: Need a meaningful memory measure out of /proc/meminfo
Date: Mon, 28 Jul 2003 12:21:57 +0300
X-Mailer: KMail [version 1.3.2]
Cc: thomasez@zelow.no
References: <200307280841.h6S8fkj21459@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200307280841.h6S8fkj21459@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 July 2003 11:51, Denis Vlasenko wrote:
> Ok, so I use Used-Buffers-Cached as a memory measure.
> It remains almost unchanged across oom.
> 
> Although I am worried that I can lie to user because above test
> shows that some 10M of buffers+cached are not really freeable.
> Also I run this box swapless, what to do with swap numbers?

FYI: this is how oom looks like under nanometer (with swap reporting added):
# nanometer d500 c m s ieth0 ilo
cpu [..........] mem  85M/247M swp 428k eth0 4.2k 3.0k lo   0    0
cpu [..........] mem  85M/247M swp 428k eth0 2.0k 1.7k lo   0    0
cpu [..........] mem  85M/247M swp 428k eth0 5.3k 5.6k lo   0    0
cpu [SSSSU.....] mem 119M/247M swp 428k eth0 3.1k 2.8k lo   0    0
cpu [SSSSSSSSSS] mem 157M/247M swp 4.0M eth0 5.0k 3.8k lo   0    0
cpu [SSSSSU....] mem 171M/247M swp 5.0M eth0 8.0k 4.0k lo 140  140
cpu [SSSSSSSSS.] mem 205M/247M swp  10M eth0 5.1k 3.3k lo   0    0
cpu [SSSS......] mem 205M/247M swp  20M eth0  76k  59k lo   0    0
cpu [SSSS......] mem 211M/247M swp  25M eth0  47k 5.7k lo   0    0
cpu [SSSSSS....] mem 221M/247M swp  32M eth0 391k 9.5k lo   0    0
cpu [SSS.......] mem 220M/247M swp  39M eth0  31k 4.2k lo   0    0
cpu [SSSS......] mem 220M/247M swp  51M eth0 7.9k 840  lo   0    0
cpu [SSSS......] mem 222M/247M swp  58M eth0  92k 7.8k lo   0    0
cpu [SS........] mem 222M/247M swp  60M eth0  85k 5.6k lo   0    0
cpu [SSSS......] mem 225M/247M swp  65M eth0  76k 4.9k lo 140  140
cpu [SSSS......] mem 227M/247M swp  72M eth0  54k 4.5k lo   0    0
cpu [SSSSSS....] mem 229M/247M swp  74M eth0 4.5k 3.2k lo   0    0
cpu [SSSSSSSSSS] mem 232M/247M swp  74M eth0  45k  35k lo   0    0
cpu [SSSSSSSSSS] mem 231M/247M swp  74M eth0 107k  29k lo   0    0
cpu [SSSSSSSSSS] mem 232M/247M swp  74M eth0 171k 6.2k lo   0    0
cpu [SSSSSSSSSS] mem 232M/247M swp  74M eth0 2.3k 1.8k lo   0    0
cpu [SSSSSSSSSS] mem 232M/247M swp  74M eth0 5.7k 5.4k lo   0    0
cpu [SSSSSSSSSS] mem 232M/247M swp  74M eth0  40k 2.9k lo   0    0
cpu [SSSSSSSSSS] mem 236M/247M swp  74M eth0 342k 9.6k lo   0    0
cpu [SSSSSSSSSS] mem 239M/247M swp  74M eth0 3.0k 2.5k lo   0    0
cpu [SSSSSSSSSS] mem 240M/247M swp  74M eth0 6.2k 4.4k lo   0    0
cpu [SSSSSSSSSS] mem 240M/247M swp  74M eth0 313k  26k lo   0    0
cpu [SSSSSSSSSS] mem 240M/247M swp  74M eth0 124k  35k lo   0    0
cpu [SSSSSSSSSS] mem 241M/247M swp  74M eth0  21k  16k lo   0    0
cpu [SSSSSS....] mem  28M/247M swp  60M eth0 380k  15k lo   0    0
cpu [..........] mem  27M/247M swp  61M eth0  10k 5.7k lo   0    0
cpu [..........] mem  27M/247M swp  61M eth0 2.8k 2.1k lo   0    0

# cat /proc/swaps
Filename                        Type            Size    Used    Priority
/mnt/auto/vfat.hda3/PAGEFILE    file            76792   54400   -1

At oom, mem reporting was showing ~6 meg as still free...
I want to do better.
--
vda
