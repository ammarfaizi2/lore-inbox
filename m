Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWE2Tx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWE2Tx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWE2Tx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:53:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:2172 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751257AbWE2Tx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:53:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMVepg4FelVXTpDzznapCggTrmEblmc6PgaLb8KN7P2EnpaosEiAZCCGmQlYFM0ePF8D7sOkqrceDzOE6pOsMy69AyfNjOuIf+Dh7Hb80Tb/9/KG6ZJHApHdVTU9bhXyMODtk5yeE2mVx0aSgrKALuxZ7IA1qnnPa1MXTh9b1gU=
Message-ID: <6bffcb0e0605291253w627570efn2cb3b6f08ba1b39@mail.gmail.com>
Date: Mon, 29 May 2006 21:53:25 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock detected!
Cc: perex@suse.cz, alsa-devel@alsa-project.org,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060529190707.GB24445@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
	 <20060529190707.GB24445@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > I get this with Ingo's lockdep patch from
> > http://people.redhat.com/mingo/generic-irq-subsystem/
>
> sigh, that patchset is not released yet ... it showed up in the genirq
> directory accidentally. (will release it later today)

Ok. So I'll wait with reporting that
http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-dmesg2
:)

>
> > ====================================
> > [ BUG: possible deadlock detected! ]
> > ------------------------------------
>
> at first sight this looks like a rare case of nested locking not yet
> covered by the lock validator. Could you try the patch below, to
> correctly express this locking construct to the lock validator?

Problem fixed. Thanks!

>
> Btw., beyond this false positive, i dont see how the lock ordering
> between ports is guaranteed - maybe there's some implicit rule that
> enforces it. And the whole grp->list_lock and grp->list_mutex lock use
> seems quite fragile - using list_lock in atomic contexts and list_mutex
> in schedulable contexts?
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
