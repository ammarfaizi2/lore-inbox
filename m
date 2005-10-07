Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVJGOoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVJGOoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVJGOoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:44:04 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:60404 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030237AbVJGOoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JJQm0rzEzoFKWgO/SLik8I0Uy5E3lqE8Ko7UkJfs0YjFG9PylY5oM5SN4FjpsplPAWt96IIDN4Dy1FT6QRfNnpHUM0V6/g/MBc5iZKiZyFDyx9gT+/BCTQ5+pReNVFLTP1LKuN11HE2vAedOH+bsGxxxHbRo250drH8knI08tag=
Message-ID: <9ef20ef30510070744l7ff1f1bbweb4da1ceb513f246@mail.gmail.com>
Date: Fri, 7 Oct 2005 11:44:00 -0300
From: Gustavo Barbieri <barbieri@gmail.com>
Reply-To: Gustavo Barbieri <barbieri@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ck] Re: [PATCH] vm - swap_prefetch-15
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510070001.01418.kernel@kolivas.org>
	 <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
	 <200510072054.11145.kernel@kolivas.org>
	 <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi,
>
> On 10/7/05, Con Kolivas <kernel@kolivas.org> wrote:
> > Good point, thanks! Any and all feedback is appreciated.
>
> Well, since you asked :-)
>
> > +/*
> > + * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
> > + * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much at a
> > + * time in laptop_mode to minimise the time we keep the disk spinning.
> > + */
> > +#define PREFETCH_PAGES()     (SWAP_CLUSTER_MAX * swap_prefetch * \
> > +                                     (1 + 9 * laptop_mode))
>
> This looks strange. Please either drop the parenthesis from PREFETCH_PAGES or
> make it a real static inline function.

Or make it a "const static" variable, so compiler will check types and
everything, but the symbol will not be present in the binary, causing
no overhead. So it could be:

const unsigned PREFETCH_PAGES = (SWAP_CLUSTER_MAX * swap_prefetch * \
        (1 + 9 * laptop_mode));

--
Gustavo Sverzut Barbieri
---------------------------------------
Computer Engineer 2001 - UNICAMP
GPSL - Grupo Pro Software Livre
Cell..: +55 (19) 9165 8010
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   MSN: barbieri@gmail.com
 Skype: gsbarbieri
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net
