Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUFZVmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUFZVmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266456AbUFZVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:42:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18841 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266451AbUFZVmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:42:40 -0400
Date: Sat, 26 Jun 2004 14:41:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040626144147.5f13cce9.davem@redhat.com>
In-Reply-To: <200406262235.15688.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406262235.15688.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004 22:35:15 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> 
> > +/* command block wrapper */
> > +struct bulk_cb_wrap {
> > +	u32	Signature;		/* contains 'USBC' */
> > +	u32	Tag;			/* unique per command id */
> > +	u32	DataTransferLength;	/* size of data */
> > +	u8	Flags;			/* direction in bit 0 */
> > +	u8	Lun;			/* LUN normally 0 */
> > +	u8	Length;			/* of of the CDB */
> > +	u8	CDB[MAX_CDB_SIZE];	/* max command */
> > +};
> 
> should be packed attributed

Only when necessary, and I do not belive any platform Linux supports
needs it in this case.

Packed attributing is _BAD_ when it isn't needed because it forces GCC
to output multiple byte-sized loads in order to access larger than
byte-sized elements because it cannot assume the proper alignment on RISC
systems.
