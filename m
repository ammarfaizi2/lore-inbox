Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293688AbSCES3G>; Tue, 5 Mar 2002 13:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293686AbSCES25>; Tue, 5 Mar 2002 13:28:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:43975 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293683AbSCES2k>;
	Tue, 5 Mar 2002 13:28:40 -0500
Date: Tue, 5 Mar 2002 10:28:35 -0800
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020305102835.B847@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com> <20020304191947.A32730@bougret.hpl.hp.com> <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020305094535.A792@bougret.hpl.hp.com> <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>; from maxk@qualcomm.com on Tue, Mar 05, 2002 at 10:13:28AM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 10:13:28AM -0800, Maksim Krasnyanskiy wrote:
>
> You _will_ drop it, if txqueue is full. TCP will back off and re-transmit
> but this will not allow TCP window to grow and you TCP performance will
> be pretty bad.

	Ok, I didn't look at the network code, so I have to take your
word for it. I would have assumed that the logical thing would be to
flow control within the network stack (like it's done in IrDA), but it
seem that I was wrong.

> I totally agree with Paul. Just decrease buffering below PPP.

	If what you say is true, I should *increase* the buffering
below PPP to make sure that packet don't get dropped above PPP.
	Think about it : for TCP, it doesn't matter if buffers are
above or below PPP, what matter is only how many there are. TCP can't
make the difference between buffers at the PPP and at IrDA level.
	Actually, it's probably better to keep the buffers as low as
possible in the stack, because less processing remain to be done on
them before beeing transmitted.

> Max

	Jean
