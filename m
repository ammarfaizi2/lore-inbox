Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSFRRPz>; Tue, 18 Jun 2002 13:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSFRRPz>; Tue, 18 Jun 2002 13:15:55 -0400
Received: from www.transvirtual.com ([206.14.214.140]:56588 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317506AbSFRRPx>; Tue, 18 Jun 2002 13:15:53 -0400
Date: Tue, 18 Jun 2002 10:15:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Mundt <lethal@chaoticdreams.org>
cc: Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22: FB_VESA - early crash in fbcon_cursor()
In-Reply-To: <20020618083829.A316@ChaoticDreams.ORG>
Message-ID: <Pine.LNX.4.44.0206181009580.5510-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks like the dispsw isn't being set and you're running into the NULL
> dereference in fbcon_cursor() upon trying to dereference it.. it looks like
> fbgen.c is the culprit here, as it never sets display->dispsw if we aren't in
> 24-bpp or have FBCON_HAS_ACCEL set..
>
> James, what's the point of th FBCON_HAS_ACCEL ifdef? It looks like all the
> accel wrapper code does is provide a wrapper to the fillrect, imageblit, and
> copyarea routines -- if the driver doesn't have accelerated ones to provide
> for itself, it just uses the cfb_fillrect/imageblit/copyarea as a fallback,
> thus it should _always_ be safe to call them.
>
> If that's not the case, we'll have to re-introduce the FBON_HAS_CFBx
> brain-damage in gen_set_disp() to keep dispsw happy.

Your right. Alot of people have been bitten by that. Especially since
people are so use to manually setting the CFB stuff. Patch applied to BK
tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


