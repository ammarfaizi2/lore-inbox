Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317449AbSFCSY0>; Mon, 3 Jun 2002 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317447AbSFCSYZ>; Mon, 3 Jun 2002 14:24:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:1009 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317446AbSFCSYX>; Mon, 3 Jun 2002 14:24:23 -0400
Date: Mon, 3 Jun 2002 14:24:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcus Sundberg <marcus@ingate.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
Message-ID: <20020603142424.A29676@redhat.com>
In-Reply-To: <ved6vepylg.fsf@inigo.ingate.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What version of ns83820.c are you using?  Version 0.17 of ns83820.c 
made significant improvements under load.  Other possibilities include 
cabling problems (watch the kernel logs for changes in link state).  
Try to find out where the packets are getting dropped by looking 
through /proc/net/snmp and other statistics counters in the kernel.

		-ben

On Wed, May 29, 2002 at 09:01:47PM +0200, Marcus Sundberg wrote:
> Hi,
> 
> I'm seeing severe packet-loss with two different types of network
> cards:
> D-link DFE-580TX (DL10050B aka OEM:ed Sundance ST201 chip) and
> SMC 9462TX (NS83820 chip)
> 
> The machine is an Athlon XP1800+ with VIA KT266 chipset and what
> I'm doing is to send several bi-directional streams of small UDP
> packets through the machine. Each stream consists of 50 UDP
> packets per second in each direction, with 200 bytes payload.
> 
> Using either Intel 21143 based cards (tulip driver) or Intel 82559
> (eepro100 driver) I can send 100 such streams through the machine
> with no packet loss (the load generators starts walking on their
> knees a bit over 100). This equals 10000 packets/second or about
> 19 Mbit/s.
> 
> However using either the Dlink cards or the SMC cards I start getting
> severe packet loss at between 50 and 70 streams. After fixing the
> sundance driver so it doesn't turn off interrupts for 3.2ms whenever
> the boguscnt counter in the interrupt handler happens to reach zero
> I can't find anything particularly bad neither in the driver nor
> in the ST201 chip spec, but packets keep getting dropped.
> (The 83820-driver I haven't looked at at all)
> 
> Before digging further into this I'd like to know if anyone have
> had similiar problems, or are using any of these cards/drivers
> without problems, or have an idea if it is the chips or the drivers
> which are broken? Or can just tell me whether these cards are
> exceptionally bad or if eepro100/tulip are exceptionally good?
> 
> I migh also take the opportunity to ask if anyone can recommend
> another 4-port (or more) 100Mbit ethernet card than the DFE-580TX?
> 
> //Marcus
> -- 
> ---------------------------------------+--------------------------
>   Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
>  Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
"You will be reincarnated as a toad; and you will be much happier."
