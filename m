Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWFACrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWFACrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFACrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:47:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:38582 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751500AbWFACrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:47:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=cUCl1PNgPLnQuQl6JvJcLI3+fG4rqoxPeqQvqg3AafGtmLD/fVg6V5IeoRK2U+g0l9Lwo6GQFoKrGBt/nJacrl/fGJHLfR+g1FARQ0J2HM13Owmq1riq5Iqh+maocxL/ZMv918wUF31nPmDcxcckvoonstJGDp58OLlkPWhNOWk=
Message-ID: <986ed62e0605311947o1eb18b6qce3bb04c41625ffc@mail.gmail.com>
Date: Wed, 31 May 2006 19:47:10 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1-lockdep: a rather strange oops
Cc: mingo@elte.hu, arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060531181430.bfe25ad5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34759_31474543.1149130030096"
References: <986ed62e0605311747qb8f7a58ybde5d3a87de74309@mail.gmail.com>
	 <20060531181430.bfe25ad5.akpm@osdl.org>
X-Google-Sender-Auth: cda61509c477137c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_34759_31474543.1149130030096
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/31/06, Andrew Morton <akpm@osdl.org> wrote:
> The original oops was a jump-to-null.  I had a few of those when getting
> the latest git-libata-all tree working, due to missing
> ata_port_operations.data_xfer vectors.  But it appears that both sata_sil.c
> and sata_promise.c do have those filled in.

Ah, but pata_pdc2027x.c doesn't. (Oh, by the way, neither does sata_sil24.c.)

I tried filling it in, with the following patch, but booting that gave
me lots of weird output before the kernel finally failed to boot from
the root device. "Lots" meaning, enough that I think I'll need a
serial console to get anything meaningful. I didn't see any oopses;
rather, it seemed like the driver was misbehaving. I don't know
whether the fault is in my patch, or elsewhere in the pdc2027x driver.
I don't have time tonight (or probably this week, for that matter) to
look into this further.

As a reminder (in case anyone else jumps into this thread in the
future), 2.6.17-rc4-mm3 works perfectly...
-- 
-Barry K. Nathan <barryn@pobox.com>

------=_Part_34759_31474543.1149130030096
Content-Type: text/plain; name=fix-pata_pdc2027x.patch.txt; 
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_enwibaj2
Content-Disposition: attachment; filename="fix-pata_pdc2027x.patch.txt"


------=_Part_34759_31474543.1149130030096--
