Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWBCLx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWBCLx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBCLx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:53:26 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:39917 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750700AbWBCLxZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:53:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NOEoMDI6Gt/u+1iZIsA05jsEJYTPX1TazbfT5zK8dTBC0Ddi/8unW0p441deC/akOuKtaEQVWTvuJNgnWbbo7Z002nYGdWybiYAfFQs3fpyFL3UXSBPrbhktVD42KTamvZfM5pk5x4fsfOWgkCSXum1i5HZJuX58BK3vhsDB4OE=
Message-ID: <84144f020602030353j221f8ae5n7fd0d56b9585596b@mail.gmail.com>
Date: Fri, 3 Feb 2006 13:53:23 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] slab leak detector (Was: Size-128 slab leak)
Cc: Andrew Morton <akpm@osdl.org>, kevin@koconnor.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <43E2F98E.6010300@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI>
	 <20060202004415.28249549.akpm@osdl.org>
	 <43E2F98E.6010300@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > Which slabs are those?  SLAB_HWCACHE_ALIGN?  If so, that's quite a lot of
> > them (more than needed, probably).

On 2/3/06, Manfred Spraul <manfred@colorfullife.com> wrote:
> Slabs with 4 kB or larger objects.

Hmm. The relevant check is:

        if ((size < 4096
             || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD)))

So for example, when object size is 4097, we _will_ get redzoning.
Shouldn't that be 5 * BYTES_PER_WORD btw?

                  Pekka
