Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVI1Tqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVI1Tqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVI1Tqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:46:42 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:36882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbVI1Tql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:46:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VwM/NCyAMPWVrREwgmojHwA5DOgNEFRuG8m49tbGRosLJRLn+qNChAm+7e2qXWo64eUyRRUcVK37RG1qrwkY7gk6kKtCIDXJOtHHuIqIYZqQlilBJZubxmsa3QJ/EyoUo1lzEUSquKiobhwpdYrEqRzWMHvlNF0GrPFblTCuMyc=
Message-ID: <355e5e5e050928124651ba8947@mail.gmail.com>
Date: Wed, 28 Sep 2005 15:46:40 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] Add disk hotswap support to libata RESEND #5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <433AE72B.1060708@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e0509261801613c9bdb@mail.gmail.com>
	 <433AE72B.1060708@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> > +     PDC2_SATA_PLUG_CSR      = 0X60, /* SATAII Plug control/status reg */
>
> Did you actually compile and test this?  :)

Yes.  And it works, which is why the compiling and testing doesn't
catch it :P  I'll change it.

> > +     case board_40518:
> > +             /* Override hotplug offset for SATAII150 */
> > +             hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
>
> add a comment /* fall through */ here

OK.

> > -     /* FIXME: check ata_device_add return value */
> > +     /* FIXME: check ata_device_add return value.  If 0, kfree(hp) */
> >       ata_device_add(probe_ent);
>
> Just leave the comment as is.  You made it worse:
>
> * if ata_device_add() returns zero, then everything is OK.
>
> * if ata_device_add() returns non-zero, then an error occured.
> kfree(hp) is but one of several things that need to be cleaned up on
> failure.

No.  ata_device_add returns nonzero on success; so say the docs. 
Since the return value is not checked here, and whether on success or
failure all of the data structures allocated in that method stick
around, I assumed that something was in the works for this.  I'll
change this to kfree(hp) on returning 0.  Please advise if I should do
something else.

> Finally, please fix the format of your subject line per
>         http://linux.yyz.us/patch-format.html
>
> Most notably, each Subject should be unique for each patch.  e.g.
>
> [PATCH 1/3] sata_promise: fix hotplug register offset
> [PATCH 2/3] libata: add device hotplug infrastructure
> [PATCH 3/3] sata_promise: add device hotplug support

OK.

Luke
