Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbSJOWcZ>; Tue, 15 Oct 2002 18:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSJOWbN>; Tue, 15 Oct 2002 18:31:13 -0400
Received: from mail.hometree.net ([212.34.181.120]:9168 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264771AbSJOWaD>; Tue, 15 Oct 2002 18:30:03 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Date: Tue, 15 Oct 2002 22:35:57 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aoi58d$hp3$1@forge.intermeta.de>
References: <20021013172138.0e394d96.skraw@ithnet.com> <20021015194538.10f54ef3.skraw@ithnet.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1034721357 32101 212.34.181.4 (15 Oct 2002 22:35:57 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 15 Oct 2002 22:35:57 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

>On Mon, 14 Oct 2002 13:38:32 +1000
>Neil Brown <neilb@cse.unsw.edu.au> wrote:

>Hello Neil,
>hello Trond,

>> This night I will try to reduce rsize/wsize from the current 8192 down to
>> 1024 as suggested by Jeff.

>Ok. The result is: it is again way slower. I was not even capable to transfer 5
>GB within 18 hours, that's when I shot the thing down.
>Anything else I can test?

nfs v2 or v3? tcp or udp? I assume nfs v3, udp and 100 Mbit switched
network between your hosts and no firewalls, routers or something like
this.

Could you post a small (some ten lines or so) tcp dump of a data transfer?

I had a hell of a time with a) a firewall dropping fragments; b) a
trunked network connection where one VLAN "pushed" another running the
NFS traffic off the trunk (Also vice versa, letting 97 Mbit/sec NFS
traffic pushing almost everything else from the trunk but this is
obviously not your problem. :-) )

If lowering the blocksize speeds up your transfers, dropping fragments
could be the problem (shorter blocks result in less fragments per
packets and increase the chance that all fragments make it over the
connection).

Could you watch the Ip: InDiscards ReasmTimeout ReasmReqds ReasmFails
and Udp: InErrors counters in /proc/net/snmp. Is any of them steadily
increasing?

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
