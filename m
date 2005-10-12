Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbVJLSaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVJLSaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJLSaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:30:07 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:947 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751497AbVJLSaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:30:06 -0400
Message-ID: <434D5574.10405@arcor.de>
Date: Wed, 12 Oct 2005 20:27:00 +0200
From: Klaus Dittrich <kladit@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc* / xinetd
References: <20051012143657.GA1625@xeon2.local.here> <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>
In-Reply-To: <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Wed, 12 Oct 2005 16:36:57 +0200, Klaus Dittrich said:
>  
>
>>I noticed a huge cpu usage of xinetd with 2.6.14-rc4 
>>starting with the first ntp request.
>>    
>>
>
>Umm.. why is xinetd listening for ntp requests at all?  I'm pretty sure that
>xinetd fighting with xntpd for control of the socket isn't going to work nicely,
>although I admit being mystified as to (a) why this ever worked for you and
>(b) what specifically changed in -rc4 to cause the CPU spin.
>
>What was the most recent kernel known to work, and what does the xinetd
>config file entry for NTP look like
>  
>

2.6.13.3 works. I can compile an try 2.6.14-rc[1,2,3].

service time
{
    type        = INTERNAL
    id          = dgram_time
    socket_type = dgram
    protocol    = udp
    user        = root
    wait        = yes
    only_from   = 192.168.168.36 192.168.168.39
}


This setup worked for years now. The machine
(192.168.168.32) is the time-server and I have
chosen this setup to simulate and verify a real
world scenario.

/etc/ntpd.conf
..
driftfile /etc/ntp.drift
logfile   /var/log/ntp 
#authenticate no
server 127.127.8.0 prefer mode 2    # Meinberg ANZ_14 (Standart Telegramm)
server 127.127.1.1                  # Local clock in case of disaster
fudge  127.127.1.1 stratum 10       # Poor stratum for local clock
--
Klaus

