Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268730AbTBZM1n>; Wed, 26 Feb 2003 07:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268763AbTBZM1n>; Wed, 26 Feb 2003 07:27:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7561
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268730AbTBZM1m>; Wed, 26 Feb 2003 07:27:42 -0500
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, schlicht@uni-mannheim.de,
       Linus Torvalds <torvalds@transmeta.com>, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030226022819.44e1873a.akpm@digeo.com>
References: <200302251908.55097.schlicht@uni-mannheim.de>
	 <20030226103742.GA29250@suse.de> <20030226015409.78e8e1fb.akpm@digeo.com>
	 <20030226111905.GA32415@suse.de>  <20030226022819.44e1873a.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046266771.8948.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 13:39:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 10:28, Andrew Morton wrote:
> Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > btw, (unrelated) shouldn't smp_call_function be doing magick checks
> > with cpu_online() ?
> 
> Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
> and waits for num_online_cpus()-1 CPUs to answer.

You cannot do that by counting without a lot of care. IPI messages do not have
guaranteed "once only" semantics. On an error a resend can and has been observed
to cause a reissue of an IPI on PII/PIII setups

