Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIMKes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIMKes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 06:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUIMKes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 06:34:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51927 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266498AbUIMKep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 06:34:45 -0400
Date: Mon, 13 Sep 2004 12:34:15 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jens Axboe <axboe@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040913103415.GA11567@devserv.devel.redhat.com>
References: <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net> <20040913073259.GF2326@suse.de> <20040913103158.GA17625@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20040913103158.GA17625@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2004 at 12:31:58PM +0200, Andrea Arcangeli wrote:
> On Mon, Sep 13, 2004 at 09:32:59AM +0200, Jens Axboe wrote:
> > completion from hardirq context, SCSI is the exception since it does it
> > defers the completion to softirq context.
> 
> which btw doesn't really make much difference at all to run it in irq
> context with irq enabled since it'll run from irq context anyways and
> you'll still depend on nested hardirqs to avoid huge latencies from
> softirq handlers (the most difference between softirq and hardirq with
> irq enabled happens if you can use spin_lock_bh instead of spin_lock_irq
> in the critical sections to protect against other cpus).

and there is improved batching under really high (irq) load, esp when you
deal with stupid hw that can't give an irq for multiple packets or IO
requests at the same time (qlogic used to be like that until the driver got
fixed)


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRXemxULwo51rQBIRAk3aAJ0dQi3eRuO+UQLw+b/0F1mpkHrsDwCgmdaa
O5YenPMY+irbEcvQB/QCthY=
=9P0M
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
