Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbUAFXxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUAFXxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:53:39 -0500
Received: from linuxhacker.ru ([217.76.32.60]:52936 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265488AbUAFXxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:53:37 -0500
Date: Wed, 7 Jan 2004 01:53:35 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, mfedyk@matchmail.com,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040106235335.GC415627@linuxhacker.ru>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFB46B0.9060101@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 07, 2004 at 02:37:20AM +0300, Hans Reiser wrote:

> >This code was never executing anyway.
> Oleg, I thought you ran a script for finding dead code last fall or 
> summer?  Any idea why it didn't find this and gcc did?  Or did you only 
> run it on reiser4?

Actually I found this dead code back then (with gcc as well), though
it was not looked all that serious. I think I decided we may want to have that
just in case sector_t will become signed oneday or something like that.
(in 2.4 the block type is still signed long, for example).

As for why gcc is finding this, but scripts (e.g. smatch) do not is because
scripts generally know nothing about variable types, so they cannot tell
this comparison was always false (and since gcc can do this for long time
already, there is no point in implementing it in scripts anyway).

Bye,
    Oleg
