Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbVJLSrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbVJLSrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVJLSrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:47:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751502AbVJLSrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:47:15 -0400
Date: Wed, 12 Oct 2005 13:46:58 -0500
From: David Teigland <teigland@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/16] GFS: headers
Message-ID: <20051012184658.GB10593@redhat.com>
References: <20051010170948.GB22483@redhat.com> <20051010190537.GA7683@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010190537.GA7683@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 11:05:37PM +0400, Alexey Dobriyan wrote:
> Please, mark on-disk structures with __le{16,32,64}. It would help
> typechecking with sparse.

Yes, that's something we're working on.

> > +#define CPIN_08(s1, s2, member, count) {memcpy((s1->member), (s2->member), (count));}
> > +#define CPOUT_08(s1, s2, member, count) {memcpy((s2->member), (s1->member), (count));}
> > +#define CPIN_16(s1, s2, member) {(s1->member) = le16_to_cpu((s2->member));}
> > +#define CPOUT_16(s1, s2, member) {(s2->member) = cpu_to_le16((s1->member));}
> > +#define CPIN_32(s1, s2, member) {(s1->member) = le32_to_cpu((s2->member));}
> > +#define CPOUT_32(s1, s2, member) {(s2->member) = cpu_to_le32((s1->member));}
> > +#define CPIN_64(s1, s2, member) {(s1->member) = le64_to_cpu((s2->member));}
> > +#define CPOUT_64(s1, s2, member) {(s2->member) = cpu_to_le64((s1->member));}
> 
> Confusing names and implementation. CP{IN,OUT}_08 do memcpy, the rest
> doesn't. "08" doesn't make sense in CPIN_08, while "16", ... do.
> CPIN_64() expect fixed-endian value or host-endian? Answer is not
> obvious until you look at a header. Fingers really want to type CPU
> every time. I ask you to write a simple script and drop these macros
> completely.

I find this to be an ideal situation for macros, actually, cutting out a
lot of tedious repetition.  I think it clarifies the code considerably in
the end.  The macros are defined immediately above their use in
gfs2_ondisk.h and there's this comment explaining what's going on:

/*
 * gfs2_xxx_in - read in an xxx struct
 * first arg: the cpu-order structure
 * buf: the disk-order buffer
 *
 * gfs2_xxx_out - write out an xxx struct
 * first arg: the cpu-order structure
 * buf: the disk-order buffer
 *
 * gfs2_xxx_print - print out an xxx struct
 * first arg: the cpu-order structure
 */

If others said the same thing as you I wouldn't hesitate to admit I'm
wrong, but several other picky style reviewers haven't said anything...

Thanks,
Dave

