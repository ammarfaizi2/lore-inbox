Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbRENQT7>; Mon, 14 May 2001 12:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262259AbRENQTj>; Mon, 14 May 2001 12:19:39 -0400
Received: from sunmail.canal-plus.fr ([194.2.208.66]:54673 "EHLO
	sunmail.canal-plus.fr") by vger.kernel.org with ESMTP
	id <S262245AbRENQTe>; Mon, 14 May 2001 12:19:34 -0400
Date: Mon, 14 May 2001 18:19:26 +0200
From: tdanis@canal-plus.fr
To: linux-kernel@vger.kernel.org
Subject: Re: Linux TCP impotency
Message-ID: <20010514181926.A31101@canal-plus.fr>
In-Reply-To: <20010513213853.A5700@ghost.btnet.cz> <20010513225415.A4950@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010513225415.A4950@home.ds9a.nl>; from ahu@ds9a.nl on Sun, May 13, 2001 at 10:54:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 10:54:15PM +0200, ahu@ds9a.nl wrote:
> On Sun, May 13, 2001 at 09:38:53PM +0200, clock@ghost.btnet.cz wrote:
> > Using 2.2.19 I discovered that running two simultaneous scp's (uses up whole
> > capacity in TCP traffic) on a 115200bps full duplex serial port nullmodem cable
> > causes the earlier started one to survive and the later to starve. Running bcp
> > instead of the second (which uses UDP) at 11000 bytes per second caused the
> > utilization in both directions to go up nearly to 100%.
> > 
> > Is this a normal TCP stack behaviour?
> 
> Might very well be. Read about different forms of (class based) queuing
> which try (and succeed) to improve IP in this respect. TCP is not fair and
> IP has no intrinsic features to help you. http://ds9a.nl/2.4Routing contains
> some explanations and links.
> 
> SFQ sounds like it might fit your bill.
> 
> Regards,
> 
> bert
> 
> -- 
> http://www.PowerDNS.com      Versatile DNS Services  
> Trilab                       The Technology People   
> 'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
> -

	I was about to report the same 'od' behaviour : I have 3
	machines, connected via a HUB at 100 Mb/s half duplex.

	From machine A : rsh B dd if=/dev/zero bs=8192 | dd of=/dev/null

	=> transfert around 10/11 MB/s (B => A)

	Now, I start a second transfert from machine C :

	rsh B dd if=/dev/zero bs=8192 | dd of=/dev/null

	=> transfert around 10/11 MB/s between B and C, almost nothing
	between A and B (ie, the connexion is stalled between A and B).

	If I stop the second transfert, I takes many seconds for
	the transfert to restart between A and B.

	On a highly saturated network, I have already seen such a
	behavior.

	Is that related to the IP adresses, the lowest being served
	first ?

A+,
-- 
	Thierry Danis
