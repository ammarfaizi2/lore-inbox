Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030753AbWI0US6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030753AbWI0US6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbWI0US6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:18:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030753AbWI0US5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:18:57 -0400
Date: Wed, 27 Sep 2006 13:18:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed:
 info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Message-Id: <20060927131849.ba64412c.akpm@osdl.org>
In-Reply-To: <451AE356.5050306@linux.intel.com>
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	<a44ae5cd0609261756w1e82087p60c18ef941657466@mail.gmail.com>
	<a44ae5cd0609262305p1d0b9aaai9db324aff0b3ba0c@mail.gmail.com>
	<451AE356.5050306@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 13:47:18 -0700
James Ketrenos <jketreno@linux.intel.com> wrote:

> +static int snprint_line(char *buf, size_t count,
> +			const u8 * data, u32 len, u32 ofs)
> +{
> +	int out, i, j, l;
> +	char c;
> +
> +	out = snprintf(buf, count, "%08X", ofs);
> +
> +	for (l = 0, i = 0; i < 2; i++) {
> +		out += snprintf(buf + out, count - out, " ");
> +		for (j = 0; j < 8 && l < len; j++, l++)
> +			out += snprintf(buf + out, count - out, "%02X ",
> +					data[(i * 8 + j)]);
> +		for (; j < 8; j++)
> +			out += snprintf(buf + out, count - out, "   ");
> +	}
> +
> +	out += snprintf(buf + out, count - out, " ");
> +	for (l = 0, i = 0; i < 2; i++) {
> +		out += snprintf(buf + out, count - out, " ");
> +		for (j = 0; j < 8 && l < len; j++, l++) {
> +			c = data[(i * 8 + j)];
> +			if (!isascii(c) || !isprint(c))
> +				c = '.';
> +
> +			out += snprintf(buf + out, count - out, "%c", c);
> +		}
> +
> +		for (; j < 8; j++)
> +			out += snprintf(buf + out, count - out, " ");
> +	}
> +
> +	return out;
> +}

I've occasionally felt that the kernel should have a generic
print-a-hunk-of-memory function (slab.c has two open-coded
implementations already).

What does the output of this one look like?
