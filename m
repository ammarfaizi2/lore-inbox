Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbTGDIMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTGDIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:12:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265848AbTGDIMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:12:48 -0400
Date: Fri, 4 Jul 2003 01:27:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, zboszor@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030704012734.77f99e74.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu>
	<3F042AEE.2000202@freemail.hu>
	<20030703122243.51a6d581.akpm@osdl.org>
	<20030703200858.GA31084@hh.idb.hist.no>
	<20030703141508.796e4b82.akpm@osdl.org>
	<20030704055315.GW26348@holomorphy.com>
	<Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>

Changing this:

>  static inline void bitmap_or(volatile unsigned long *dst, const volatile unsigned long *bitmap1,
>  				const volatile unsigned long *bitmap2, int bits)
>  {
>  	int k;
> 
>  	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
>  		dst[k] = bitmap1[k] | bitmap2[k];
>  }

to this:

static inline void bitmap_or(unsigned long *dst, unsigned long *bitmap1,
                                unsigned long *bitmap2, int bits)
{
        int k;
        int nr = BITS_TO_LONGS(bits);

        for (k = 0; k < nr; k++)
                dst[k] = bitmap1[k] | bitmap2[k];
}

fixes it up, and looks nicer anyway.  Removing the volatiles (what were
they doing there?) did not fix it.  The `nr' thing fixed it.  

I shall make that change.
