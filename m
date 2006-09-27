Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031214AbWI0XFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031214AbWI0XFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031215AbWI0XFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:05:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031214AbWI0XFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:05:48 -0400
Date: Wed, 27 Sep 2006 16:02:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed:
 info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Message-Id: <20060927160230.d9325a18.akpm@osdl.org>
In-Reply-To: <451B01FB.2000408@linux.intel.com>
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	<a44ae5cd0609261756w1e82087p60c18ef941657466@mail.gmail.com>
	<a44ae5cd0609262305p1d0b9aaai9db324aff0b3ba0c@mail.gmail.com>
	<451AE356.5050306@linux.intel.com>
	<20060927131849.ba64412c.akpm@osdl.org>
	<451B01FB.2000408@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 15:58:03 -0700
James Ketrenos <jketreno@linux.intel.com> wrote:

> >> +			out += snprintf(buf + out, count - out, "%c", c);
> >> +		}
> >> +
> >> +		for (; j < 8; j++)
> >> +			out += snprintf(buf + out, count - out, " ");
> >> +	}
> >> +
> >> +	return out;
> >> +}
> > 
> > I've occasionally felt that the kernel should have a generic
> > print-a-hunk-of-memory function (slab.c has two open-coded
> > implementations already).
> > 
> > What does the output of this one look like?
> 
> The formatting was done to look pretty similar to generic hex editors/dumpers:
> 
> 00000000 80 00 00 00 FF FF FF FF  FF FF 00 14 6C 9E C1 1E   ........ ....l...
> 00000010 00 14 6C 9E C1 1E 00 AF  86 07 D7 DC 11 00 00 00   ..l..... ........
> 00000020 64 00 01 04 00 07 4E 45  54 47 45 41 52 01 08 82   d.....NE TGEAR...
> 00000030 84 8B 96 24 30 48 6C 03  01 0B 05 04 00 01 00 00   ...$0Hl. ........
> 00000040 2A 01 02 2F 01 02 32 04  0C 12 18 60 DD 06 00 10   *../..2. ...`....
> 00000050 18 02 00 00
> 
> The above was generated via printk_buf() with an 84 byte buffer passed in.

Very smooth.  Perhaps some nice person will turn it into lib/print-line.c or
something for us (hint).
