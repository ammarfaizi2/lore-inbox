Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUKYJ1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUKYJ1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUKYJ1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:27:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:28943 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261283AbUKYJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:26:44 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041124203349.7982efb7.akpm@osdl.org>
References: <1101314988.1714.194.camel@mulgrave>
	 <1101323621.2811.24.camel@laptop.fenrus.org>
	 <1101356864.4007.35.camel@mulgrave> <20041124203349.7982efb7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1101370853.2659.1.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 25 Nov 2004 09:20:53 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 20:33 -0800, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> >  +config X86_HZ
> >  +       int "Clock Tick Rate"
> >  +       default 1000 if !(M386 || M486 || M586 || M586TSC || M586MMX)	
> >  +       default 100 if (M386 || M486 || M586 || M586TSC || M586MMX)	
> >  +       help
> >  +	  Select the kernel clock tick rate in interrupts per second.
> >  +	  Slower processors should choose 100; everything else 1000.
> 
> I guess we don't need the help, given that it's not a menuisable option. 
> (There was a make-HZ-selectable patch once, and Linus spat it out).

I'd rather have it as menu-visible option, but I can see how arbitrary
HZ gets spat out. How about a radio-button like thing with "100" and
"1000" in it.

HZ=1000 costs you 1% HPC performance, and for slower machines probably more. Also some hw (with slow smm) really doesn't likeit.

