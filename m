Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268542AbTANDKi>; Mon, 13 Jan 2003 22:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbTANDKi>; Mon, 13 Jan 2003 22:10:38 -0500
Received: from havoc.daloft.com ([64.213.145.173]:39908 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268542AbTANDKf>;
	Mon, 13 Jan 2003 22:10:35 -0500
Date: Mon, 13 Jan 2003 22:19:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030114031921.GD404@gtf.org>
References: <20030114025452.656612C385@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114025452.656612C385@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 12:55:40PM +1100, Rusty Russell wrote:
> +
> +char *kstrdup(const char *s, int gfp)
> +{
> +	char *buf = kmalloc(strlen(s)+1, gfp);
> +	if (buf)
> +		strcpy(buf, s);
> +	return buf;
> +}

Poo -- why not store the length in a temp, since the compiler does it
behind the scenes anyway, and then memcpy instead of strcpy?
(remember to store the +1 too, since you want to memcpy the null...)

	Jeff



