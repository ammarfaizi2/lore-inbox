Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVAYV15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVAYV15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVAYVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:24:28 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26640 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262156AbVAYVUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:20:15 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Denis Zaitsev <zzz@anda.ru>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Onboard Ethernet Pro 100 on a SMP box: a very strange errors
Date: Tue, 25 Jan 2005 23:19:11 +0200
User-Agent: KMail/1.5.4
Cc: linux-net@vger.kernel.org, nfs@lists.sourceforge.net
References: <20050122014646.A1038@natasha.ward.six>
In-Reply-To: <20050122014646.A1038@natasha.ward.six>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252319.11304.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 22:46, Denis Zaitsev wrote:
> The long story is:
> 
> There is a Dual-processor Intel Server Board STL2 with two P-III/800
> and an onboard Intel 82557-based ethernet card.  The box has all the
> /usr and nearly all of the /var filesystems mounted over NFS.  And the
> box works for months without any problems around the NFS.  So, I think
> that the ethernet card just works fine.
> 
> But I have some enigmatic problems when I copying _some_ files from an
> NFS to the local fs: the process is freezes on the middle.
> 
> 1) Only _some_ files can't be copied.  There are:
> 
>    gcc-testsuite-3.4-20041217.tar.bz2
> 
>    krb5-1.3.6-signed.tar
> 
>    X430src-1.tgz
> 
>    They are the well-known sources from the well-known ftp and web
>    places.  And I don't think that it's the full list, just the files
>    for which I have met the problem.
> 
> 2) Only _these_ files can't be copied.  Any other is copied plainly.
> 
> 3) These files _never_ can be copied.
> 
> 4) The copy process always freezes at the same place (per file - the
>    each file has its own place).
> 
> In short: it's a list of files, on which the copying is always freezes
> and always freezes exactly the same way.  And there are no any
> exception - I have freezeng each time.
> 
> The freezing is forever.  The freezed process is in D state, its
> /proc/PID/wchan contains page_sync.  Each such process eats 1.0 from
> /proc/loadavg.  And the process can't be killed by any signal.
> 
> Then, copying by dd bs=1024 ... just succeeds.  After that cp succeeds
> too - I think it's because of caching.

Because this causes different packets to be sent.

> Then, there is no visual correlation with the size of the file.  So,
> it seems that the content of the file is involved...  But it is
> enigmatic.

Something corrupts packets. It can be sending NIC, switch in the middle,
or receiving NIC.

Do 'tcpdump -nliethN -s0 -Xx udp >log' on both ends while you do the copying
and compare last dozen of packets.
--
vda

