Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSGLW3K>; Fri, 12 Jul 2002 18:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSGLW3J>; Fri, 12 Jul 2002 18:29:09 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:1713 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S318038AbSGLW3I>; Fri, 12 Jul 2002 18:29:08 -0400
Message-ID: <3D2F58A7.6CC58590@nortelnetworks.com>
Date: Fri, 12 Jul 2002 18:31:03 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 64 bit netdev stats counter
References: <1026503694.26819.4.camel@dell_ss3.pdx.osdl.net>
		<Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu> 
		<20020712.145835.91443486.davem@redhat.com> <1026516053.9958.33.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-07-12 at 22:58, David S. Miller wrote:
> > 32-bit values aren't atomic either, what is the issue?
> > We don't use atomic_t ops on these counters so they aren't
> > guarenteed in any way right now even.  GCC is going to
> > output "incl MEM" or similar for net_stats->counter++, since
> > it lacks the 'lock;' prefix it is not atomic.
> 
> The behaviour is quite different though. On a 32bit counter the worst we
> do is lose a few counts. On a 64bit one on 32bit cpus its quite likely
> gcc will output
> 
>                 increment low 32bit
>                 if zero
>                         increment high
> 
> Which means we can rapidly get 2^32 out of sync

Isn't this the same as 32-bit counters on a machine that doesn't do atomic
32-bit ops?  Although in that case you could only be 2^16 off...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
