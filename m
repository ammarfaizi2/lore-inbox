Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273102AbRIRRnV>; Tue, 18 Sep 2001 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIRRnL>; Tue, 18 Sep 2001 13:43:11 -0400
Received: from [213.82.86.194] ([213.82.86.194]:38671 "EHLO fatamorgana.net")
	by vger.kernel.org with ESMTP id <S273098AbRIRRm7>;
	Tue, 18 Sep 2001 13:42:59 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roberto Arcomano <berto@fatamorgana.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proxy arp bug on shaper device
Date: Tue, 18 Sep 2001 19:46:42 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01091819464200.01127@berto.casa.it>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Julian,
when I decided to write the patch I had to solve following problem:
LINUX with shaper devices and proxy arp   ----    WIN clients (which couldn't
start up).

I tried to solve problem with simple trick (like disable proxy arp or change
routing info), but I couldn't. Then, I realized that the problem was at
"kernel" level, cause I had:

host           interface
HOST1      shaper0 (eth0)

So, when HOST1 started up, kernel (wrongly) sent it an ARP REPLY cause source
interface was different from destination interface (for the host). This is
really wrong, I think, cause shaper0 is the SAME interface (at physical
level, where proxy arp works) of eth0 (it uses same first 2 level ISO/OSI,
shaper has to be managed exactly as eth0).

In the end I say that I prefer kernel mode solution, rather than use mode
solution.

I Hope to has been clear.
Let me know what you think.
Regards
Roberto Arcomano

Il 15:24, martedì 18 settembre 2001, hai scritto:
> Hello,
>
> On Tue, 18 Sep 2001, Roberto Arcomano wrote:
> > Hello Julian,
> > thank you very much for your answer. I'm sure your solution would be ok,
> > but I think the right solution should be modify the kernel, cause, shaper
> > device cannot be managed like a physical device (I mean about route check
> > before sending ARP REPLY): I think it is more clear than other solutions.
>
> 	If this is true then you have to provide support for all
> other devices, for example, tunnels. The common for such setups is
> that asymmetric routing is used. OTOH, your change drops the ARP
> probe without updating the neighbour state. BTW, do you see any
> incoming traffic on the shaper device?
>
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>

-------------------------------------------------------
