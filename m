Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFQFar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTFQFar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:30:47 -0400
Received: from mailf.telia.com ([194.22.194.25]:44522 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S264590AbTFQFaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:30:46 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <3EEEAA9C.5060801@telia.com>
Date: Tue, 17 Jun 2003 07:43:56 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi> <20030615191125.I5417@flint.arm.linux.org.uk> <87el1vcdrz.fsf@jumper.lonesom.pp.fi> <20030615212814.N5417@flint.arm.linux.org.uk> <87he6qc3bb.fsf@jumper.lonesom.pp.fi> <20030616085403.A5969@flint.arm.linux.org.uk> <3EEE173A.8040802@telia.com> <20030616212700.J13312@flint.arm.linux.org.uk>
In-Reply-To: <20030616212700.J13312@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Great, this helps a lot.  While I remove the bullet from my foot, could
> you test this patch please?
> 
> --- linux/drivers/pcmcia/cs.c.old	Mon Jun 16 21:17:45 2003
> +++ linux/drivers/pcmcia/cs.c	Mon Jun 16 21:24:23 2003
> @@ -817,7 +817,8 @@
>  				if ((skt->state & SOCKET_PRESENT) &&
>  				     !(status & SS_DETECT))
>  					socket_shutdown(skt);
> -				if (status & SS_DETECT)
> +				if (!(skt->state & SOCKET_PRESENT) &&
> +				    status & SS_DETECT)
>  					socket_insert(skt);
>  			}
>  			if (events & SS_BATDEAD)

A quick test with this patch against 2.5.71: Works OK now!

Thank you

Peter

