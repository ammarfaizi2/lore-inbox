Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbUKPXip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUKPXip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKPXga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:36:30 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:11795 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261899AbUKPXf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:35:59 -0500
Date: Tue, 16 Nov 2004 23:35:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <419A38EE.8000202@aknet.ru>
Message-ID: <Pine.LNX.4.58L.0411162226500.8068@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
 <4198EFE5.5010003@aknet.ru> <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
 <419A38EE.8000202@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Stas Sergeev wrote:

> I don't think it worked. I do not even
> claim there is still some bug to that.
> But I know that nmi_watchdog=1 worked -
> thats for sure. I think there was some
> fallback, which is now either broken or

 Indeed there was and it still is there, namely the following code:

	if (nmi_watchdog != NMI_NONE)
		nmi_watchdog = NMI_LOCAL_APIC;

in detect_init_APIC().

> disabled intentionally, and that's what
> I wanted to find out to make sure that
> everything works as expected.

 Thanks for your insistence -- it helps.  We probably want to rewrite the
fallback differently.

> I applied your patch and here are 2 logs -
> one from older kernel, one with -mm5 with
> patch. Both have nmi_watchdog=1, but the
> NMI works only with the old one.
> Does this shed some light?

 Thanks -- they prove you have no I/O APIC and the quoted fallback should 
indeed be in effect.

  Maciej
