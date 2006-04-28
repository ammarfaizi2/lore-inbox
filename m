Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWD1Lxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWD1Lxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWD1Lxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:53:48 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:8627 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030287AbWD1Lxs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:53:48 -0400
In-Reply-To: <20060428094320.GC30532@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF5222FCF0.13191785-ON4225715E.00410FC5-4225715E.00415AAD@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 28 Apr 2006 13:53:50 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 28/04/2006 13:54:53
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 04/28/2006 11:43:20 AM:
> On Fri, 28 April 2006 11:22:25 +0200, Michael Holzheu wrote:
> > +
> > +static inline int info_blk_hdr__size(enum diag204_format type)
> > +{
> > +   if (type == INFO_SIMPLE)
> > +      return sizeof(struct info_blk_hdr);
> > +   else /* INFO_EXT */
> > +      return sizeof(struct x_info_blk_hdr);
> > +}
> > +
> > +static inline __u8 info_blk_hdr__npar(enum diag204_format type, void
*hdr)
> > +{
> > +   if (type == INFO_SIMPLE)
> > +      return ((struct info_blk_hdr *)hdr)->npar;
> > +   else /* INFO_EXT */
> > +      return ((struct x_info_blk_hdr *)hdr)->npar;
> > +}
> > +
> > +static inline __u8 info_blk_hdr__flags(enum diag204_format type, void
*hdr)
> > +{
> > +   if (type == INFO_SIMPLE)
> > +      return ((struct info_blk_hdr *)hdr)->flags;
> > +   else /* INFO_EXT */
> > +      return ((struct x_info_blk_hdr *)hdr)->flags;
> > +}
> > +
> > +static inline __u16 info_blk_hdr__pcpus(enum diag204_format type,void
*hdr)
> > +{
> > +   if (type == INFO_SIMPLE)
> > +      return ((struct info_blk_hdr *)hdr)->phys_cpus;
> > +   else /* INFO_EXT */
> > +      return ((struct x_info_blk_hdr *)hdr)->phys_cpus;
> > +}
>
> Hmm.  Another possible approach would be to create a small struct with
> a couple of functions, have one function each for type==INFO_SIMPLE
> and type==INFO_EXT and fill the struct either with one set of
> functions or the other.
>
> Whether that would make more sense than your current approach, I
> cannot judge.  Iirc, function calls are still fairly expensive on
> s390, so maybe not.
>

We discussed that! If we would have more than two data formats
we would have taken your approach. But for only two, I think
it is ok to do it my way!

Michael

