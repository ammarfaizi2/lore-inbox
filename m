Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVATIgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVATIgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVATIgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:36:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50567 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262072AbVATIgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:36:12 -0500
Date: Thu, 20 Jan 2005 09:35:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050120083559.GC12665@elte.hu>
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEA86D.7020108@comcast.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.8, required 5.9, BAYES_00 -4.90,
	NORMAL_HTTP_TO_IP 0.10
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Richard Moser <nigelenki@comcast.net> wrote:

> On a final note, isn't PaX the only technology trying to apply NX
> protections to kernel space? [...]

NX protection for kernel-space overflows on x86 has been part of the
mainline kernel as of June 2004 (released in 2.6.8), on CPUs that
support the NX bit - i.e. latest AMD and Intel CPUs. Let me quote from
the commit log:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1757.49.12

  [...]
  furthermore, the patch also implements 'NX protection' for kernelspace
  code: only the kernel code and modules are executable - so even
  kernel-space overflows are harder (in some cases, impossible) to
  exploit. Here is how kernel code that tries to execute off the stack is
  stopped:

   kernel tried to access NX-protected page - exploit attempt? (uid: 500)
   Unable to handle kernel paging request at virtual address f78d0f40
    printing eip:
   ...

implemented, split out and brought to you by yours truly, as part
of the exec-shield project. (You know, the one not developed by that 
'scheduler developer' ;-)

	Ingo
