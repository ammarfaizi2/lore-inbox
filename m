Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276278AbRJCNhS>; Wed, 3 Oct 2001 09:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276270AbRJCNhN>; Wed, 3 Oct 2001 09:37:13 -0400
Received: from babel.spoiled.org ([217.13.197.48]:29230 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S276278AbRJCNg2>;
	Wed, 3 Oct 2001 09:36:28 -0400
From: Juri Haberland <juri@koschikode.com>
To: Frank.dekervel@student.kuleuven.ac.Be (Frank Dekervel)
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtu problem with masquerading+pppoe(adsl) setup
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <200110031300.PAA17063@lambik.cc.kuleuven.ac.be>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20011003133656.30C0D1195A@a.mx.spoiled.org>
Date: Wed,  3 Oct 2001 15:36:56 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110031300.PAA17063@lambik.cc.kuleuven.ac.be> you wrote:
> 
>  Hello, (i am sorry if this is the wrong place to ask)
>  
>  despite the frequent discussions concerning this topic on usenet, i failed 
>  to solve my problem:
>  
>  - i have a debian potatoe box that acts as a masquerading server for a 
>  heterogenous win2k/winnt/mac LAN. pppoe works fine, and so does 
>  masquerading ... almost
>  
>  - the kernel i installed is the latest 2.2 kernel (2.2.19)
>  
>  the problem:
>  
>  i can't access some sites from the masq clients, while i can access them 
>  from the masq server. (like www.vitrine.be)
>  
>  The problem seems to be widely known, and seems to be an MTU+no-fragment 
>  packets issue. and indeed:
>  - the MTU on my LAN is 1500 bytes
>  - the MTU on my ppp connection is 1492 bytes.
>  
>  on the archives, i found the following solutions:
>  - raising the ppp MTU to 1500 bytes. it won't work. even if i specify 1500, 
>  the mtu is still 1492.
>  - lowering the mtu of the LAN to 1492 bytes. thats not an option according 
>  to my boss.
>  - upgrade to something newer than 2.2.14. i run 2.2.19 and i still have the 
>  problem.
>  
>  So my questions are:
>  
>  - are there other options ? i read some vague german things about msschamp 
>  or something like that, but i don't know if they are even related.
>  
>  - will an upgrade to linux 2.4 or the kernelspace pppoe driver fix my 
>  problem ? (i would like to keep my current setup, i don't know how 
>  difficult it is to upgrade a potatoe box to such a recent version ..)

Well, upgrading to a recent 2.4 kernel gives you the possebility to use
the TCPMSS target in iptables which resolves your problems.

I'm also running a Linux masquerading box on a ADSL (T-DSL) line and I have 
no problems at all (I can access the site you mentioned fine) with
the following line in iptables:

$IPTABLES -I FORWARD -j TCPMSS -o $FW_WORLD_DEV --clamp-mss-to-pmtu -p tcp --tcp-flags SYN,RST SYN

Cheers,
Juri

-- 
Juri Haberland  <juri@koschikode.com> 

