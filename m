Return-Path: <linux-kernel-owner+w=401wt.eu-S1423158AbWLVPIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423158AbWLVPIR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWLVPIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:08:16 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:33033 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965189AbWLVPIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:08:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmO9xurY4DAX+BHeO1uB2muEWCAe/9cJ8Ds74uLWhwSfnsmthRkhHR0BqkJ29VXC0RuZEUjBShs0PYTHsR3Kb+3A76TKYySN4W2FDM3vrgS3cQ2QLUEvgMjTL6dY1PXm6+RGMU9SoYW6xIKruy60lbS7ozTxJw31ItcOsxoSEFM=
Message-ID: <97a0a9ac0612220708h7c54056as4953a0a761a00b2@mail.gmail.com>
Date: Fri, 22 Dec 2006 08:08:14 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Andrew Morton" <akpm@osdl.org>, "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Linus Torvalds <torvalds@osdl.org> wrote:

> Andrew located at least one bug: we run cancel_dirty_page() too late in
> "truncate_complete_page()", which means that do_invalidatepage() ends up
> not clearing the page cache.
>
> His patch is appended.

Thanks. I'll try this out later today.

> But it sounds like I probably misunderstood something, because I thought
> that Martin had acknowledged that this patch actually worked for him.
> Which sounded very similar to your setup (he has a 32M ARM box too, no?)

Yup, we have the same machines (Linksys NSLU2) and are running the
same test case (installing Debian). However, I'm not sure what kernel
version he had used for his latest test. I presumed 2.6.20-git,
whereas I had used 2.6.19.

> Maybe it's mount option issue? I've got data=ordered on my machine, are
> you perhaps runnign with something else?

We are also using ordered.

/dev/scsi/host0/bus0/target0/lun0/part1 /target ext3 rw,data=ordered 0 0

Gordon

-- 
Gordon Farquharson
