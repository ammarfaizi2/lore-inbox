Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUESA6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUESA6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUESA6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:58:45 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:56076 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263752AbUESA6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:58:44 -0400
To: ebiederman@lnxi.com (Eric W. Biederman)
Cc: ebiederm@xmission.com (Eric W. Biederman), Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       Greg KH <greg@kroah.com>
Subject: Re: readq/writeq on 32bit machines
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com> <20040517160508.63e1ddf0.akpm@osdl.org>
	<20040517161212.659746db.akpm@osdl.org> <40A94857.9030507@pobox.com>
	<20040517163356.506a9c8f.akpm@osdl.org> <40A94DF7.30307@pobox.com>
	<20040517184621.0da52a3c.akpm@osdl.org> <40A96E11.5040000@pobox.com>
	<m1vfit3939.fsf_-_@ebiederm.dsl.xmission.com>
	<52fz9xpp5l.fsf@topspin.com> <m3hdudtk5h.fsf@maxwell.lnxi.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 18 May 2004 17:58:36 -0700
In-Reply-To: <m3hdudtk5h.fsf@maxwell.lnxi.com>
Message-ID: <52isetmdvn.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 May 2004 00:58:36.0892 (UTC) FILETIME=[6A9861C0:01C43D3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eric> I picked that up out of xor.h where the raid code does
    Eric> something similar, so if there is a problem it needs to be
    Eric> fixed there as well.

OK, I found this in raid6x86.h:

/* On i386, the stack is only 8-byte aligned, but SSE requires 16-byte
   alignment.  The +3 is so we have the slack space to manually align
   a properly-sized area correctly.  */

So I guess __attribute__((aligned(8))) is OK on i386, but 16-byte
alignment needs to be handled manually.

By the way, I haven't seen my mails on this thread make it to lkml
(despite having linux-kernel@vger.kernel.org in my Cc: line).
Obviously they're going out, since you replied to one, but they seem
to be getting eaten somewhere.

Thanks,
  Roland
