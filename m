Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSDCLn6>; Wed, 3 Apr 2002 06:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDCLns>; Wed, 3 Apr 2002 06:43:48 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:52884 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S311211AbSDCLn3>;
	Wed, 3 Apr 2002 06:43:29 -0500
Date: Wed, 3 Apr 2002 13:42:41 +0200
From: Andras Kis-Szabo <kisza@securityaudit.hu>
To: James Morris <jmorris@intercode.com.au>
Cc: netfilter-devel@lists.samba.org, Phil <biondi@cartel-securite.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: ICMP time exceeded DNAT info leak ? (fwd)
Message-ID: <20020403134241.A24198@sch.bme.hu>
In-Reply-To: <Mutt.LNX.4.44.0204031512230.26899-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.23i
X-Organization: SecurityAudit.hu
X-PGP-Fingerprint: 668B 0727 93F1 BD61 51F1  3971 9EBB 2798 E295 F49F
X-PGP-KeyID: E295F49F
X-Operating-System: SunOS 5.8 sun4u sparc SUNW,Ultra-2
X-PGP-Key-Expire: 01.01.2003.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris ....................................... (2002. április 03.)

 Hi!

> iptables -t nat -A PREROUTING -p tcp --dport 666 -j DNAT --to 172.16.3.26:22
 
> pbi@exchange1:~$ sudo ./nmap -sS -P0 mymachine -p 22,23,666,667 -t 9
> Starting nmap V. 2.54BETA32 ( www.insecure.org/nmap/ )
> Interesting ports on mymachine:
> Port       State       Service
> 22/tcp     open        ssh
> 23/tcp     filtered    telnet
> 666/tcp    UNfiltered  doom                     DNAT to 192.168.8.10:22
> 667/tcp    UNfiltered  unknown                  DNAT to 192.168.26.10:22
 
You should try this (as a workaround):
iptables -t nat -A PREROUTING -p tcp --dport 666 -m ttl --ttl-gt 4 -j DNAT --to 172.16.3.26:22
iptables -t nat -A PREROUTING -m ttl --ttl-lt 5 -j LOG --log-prefix "Evil
hax0r "

(So it is not hardcoded as in IPFilter ... )

Regards,

	kisza

-- 
    Andras Kis-Szabo       Security Development, Design and Audit
-------------------------/        Zorp, NetFilter and IPv6
 kisza@SecurityAudit.hu /-----Member of the BUTE-MIS-SEARCHlab---------->
