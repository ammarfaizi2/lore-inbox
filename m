Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJFKAC>; Sat, 6 Oct 2001 06:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJFJ7w>; Sat, 6 Oct 2001 05:59:52 -0400
Received: from cs82093.pp.htv.fi ([212.90.82.93]:21376 "EHLO cs82093.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S275097AbRJFJ7m>;
	Sat, 6 Oct 2001 05:59:42 -0400
Message-ID: <3BBED618.768332@welho.com>
Date: Sat, 06 Oct 2001 12:59:52 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: cwidmer@iiic.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: unnecessary retransmit from network stack
In-Reply-To: <200110051229.f95CTvN00624@mail.swissonline.ch> <20011005.161105.78709492.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Christian Widmer <cwidmer@iiic.ethz.ch>
>    Date: Fri, 5 Oct 2001 14:29:53 +0200
> 
>    why does net_dev.hard_start_xmit get called multiple times
>    with the same tcp packet?
> 
> Because the ACK is not coming back for those packets within the RTO
> (which for a local network is very low).  Check your TCP dumps,
> the ACKs of the original data packets are being dropped in transit.

Well, TCP certainly shouldn't be sending two retransmissions
back-to-back within 2ms, especially with nothing received in between.
Not with RTO (which in Linux is never below 20ms, and according to RFC
should be conservatively rounded up to 1 second), nor with fast
retransmits or SACK.

Just an observation.

	MikaL
