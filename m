Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUF2HMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUF2HMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUF2HMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 03:12:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:40577 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265517AbUF2HMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 03:12:46 -0400
Date: Tue, 29 Jun 2004 09:12:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: Scott Wood <scott@timesys.com>, oliver@neukum.org, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040629071246.GA1206@ucw.cz>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628132531.036281b0.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:25:31PM -0700, David S. Miller wrote:
> On Mon, 28 Jun 2004 10:15:17 -0400
> Scott Wood <scott@timesys.com> wrote:
> 
> > On Sun, Jun 27, 2004 at 02:26:28PM -0700, David S. Miller wrote:
> > > On Sun, 27 Jun 2004 12:42:21 +0200
> > > Oliver Neukum <oliver@neukum.org> wrote:
> > > 
> > > > OK, then it shouldn't be used in this case. However, shouldn't we have
> > > > an attribute like __nopadding__ which does exactly that?
> > > 
> > > It would have the same effect.  CPU structure layout rules don't pack
> > > (or using other words, add padding) exactly in cases where it is
> > > needed to obtain the necessary alignment.
> > 
> > No, it wouldn't, as you could drop the assumption that the base of
> > the struct can be misaligned.  Thus, the compiler only needs to
> > generate unaligned loads and stores for fields which are unaligned
> > within the struct, which in this case would be none of them.
> > 
> > While it's rather unlikely that a struct like this one would ever
> > need packing, it would help those structs that do need it by reducing
> > the number of fields subjected to unaligned loads and stores.
> 
> That's true.  But if one were to propose such a feature to the gcc
> guys, I know the first question they would ask.  "If no padding of
> the structure is needed, why are you specifying this new
> __nopadding__ attribute?"

You may have a struct, which itself might 'need' padding somewhere
inside, however the structure start will always be aligned. Using
__nopadding__ you should be much better off than using __packed_ in this
case, because GCC can use the right aligned/nonaligned accesses for the
members of the structure, because it knows which will be aligned and
which not.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
