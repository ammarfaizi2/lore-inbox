Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271502AbRHUMCD>; Tue, 21 Aug 2001 08:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271569AbRHUMBx>; Tue, 21 Aug 2001 08:01:53 -0400
Received: from firewall.fesppr.br ([200.238.157.11]:26612 "EHLO
	smtp2.fesppr.br") by vger.kernel.org with ESMTP id <S271502AbRHUMBn>;
	Tue, 21 Aug 2001 08:01:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IPX in 2.4.[5-9]
Message-ID: <998395315.3b824db337527@webmail.fesppr.br>
Date: Tue, 21 Aug 2001 09:01:55 -0300 (BRT)
From: Alexandre Hautequest <hquest@fesppr.br>
In-Reply-To: <998343425.3b818301718cd@webmail.fesppr.br> <20010821014517.G1394@ppc.vc.cvut.cz>
In-Reply-To: <20010821014517.G1394@ppc.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.4
X-Originating-IP: 172.16.40.2
X-WebMail-Company: Fundacao de Estudos Sociais do Parana
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you do not have ncpfs-2.2.0.16, but anything newer, or older than
> 2.2.0.12, then it should work. If it reports 8847, it means that you have
> misconfigured network (search for 8847 on support.novell.com). You have either
> no server on 802.2, or you (or admin) disabled Reply To Get Nearest Server on
> all servers connected to your wire. You must enable it at least on one of
> them.

Ok, here we goes again ;)

NCPFS is 2.2.0.18. Both mine NW5 (5.01 SP5) servers are in IP and 802.2 IPX
network. No one single line was changed in my NW servers since last year, but --
as i wrote before -- the amazing thing is in 2.4.5 works! i just change kernel
version... no any other change.

About the support search: Nothing was found with this code number, i'm
mantaining telephone contact w/ Novell support ppl here, to ask what this code
means -- hope they knows.

IIRC, this error was showed me some time ago, when i was in another subnet,
trying to route IPX packets to my servers net, and my router (Linux 2.2.19) was
misconfigured -- i was binding primary to a wrong iface, now it works. My
station -- just one iface -- who is in the same net/switch/room of the server
doesn't. :(

I'm thinking about the module load. It doesn't matter if the module is or not
loaded, the error is the same. Look:

root@condor:/home/hquest# lsmod
Module                  Size  Used by
root@condor:/home/hquest# slist
slist: Server not found (0x8847) in ncp_open
root@condor:/home/hquest# modprobe ipx
root@condor:/home/hquest# lsmod
Module                  Size  Used by
ipx                    19616   0  (unused)
root@condor:/home/hquest# ipx_configure --auto_primary=on --auto_interface=on
root@condor:/home/hquest# /sbin/ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:00:F8:08:BD:A1  
          inet addr:172.16.40.2  Bcast:172.16.255.255  Mask:255.255.0.0
          IPX/Ethernet 802.2 addr:AC100000:0000F808BDA1
(Yes, AC100000 -- 172.16 -- *is* my IPX net)
root@condor:/home/hquest# slist
slist: Server not found (0x8847) in ncp_open
root@condor:/home/hquest# _

--
Alexandre Hautequest - hquest at fesppr.br
Fundação de Estudos Sociais do Paraná - http://www.fesppr.br/
Centro de Administração de Redes - CAR
"Eu acreditava no sistema. Até que eles formataram minha família"

Registered Linux User #116289 http://counter.li.org/

"Ninguém é melhor do que todos nós juntos."
Equipe Zeus Competições - www.gincaneiros-zeus.com.br

-------------------------------------------------
Esta mensagem foi enviada pelo WebMail da FESP.
Conheça a FESP: http://www.fesppr.br/
