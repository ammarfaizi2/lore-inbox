Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUFZV4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUFZV4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUFZV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:56:04 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64978 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266459AbUFZVzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:55:50 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Sat, 26 Jun 2004 23:56:49 +0200
User-Agent: KMail/1.6.2
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406262235.15688.oliver@neukum.org> <20040626144147.5f13cce9.davem@redhat.com>
In-Reply-To: <20040626144147.5f13cce9.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406262356.49275.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. Juni 2004 23:41 schrieb David S. Miller:
> On Sat, 26 Jun 2004 22:35:15 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> > 
> > > +/* command block wrapper */
> > > +struct bulk_cb_wrap {
> > > +	u32	Signature;		/* contains 'USBC' */
> > > +	u32	Tag;			/* unique per command id */
> > > +	u32	DataTransferLength;	/* size of data */
> > > +	u8	Flags;			/* direction in bit 0 */
> > > +	u8	Lun;			/* LUN normally 0 */
> > > +	u8	Length;			/* of of the CDB */
> > > +	u8	CDB[MAX_CDB_SIZE];	/* max command */
> > > +};
> > 
> > should be packed attributed
> 
> Only when necessary, and I do not belive any platform Linux supports
> needs it in this case.
> 
> Packed attributing is _BAD_ when it isn't needed because it forces GCC
> to output multiple byte-sized loads in order to access larger than
> byte-sized elements because it cannot assume the proper alignment on RISC
> systems.

Unless I am mistaken, this structure is transfered as such over the bus,
so IMHO here it is needed.

	Regards
		Oliver
