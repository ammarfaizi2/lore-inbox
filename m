Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318982AbSH1V2E>; Wed, 28 Aug 2002 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSH1V2E>; Wed, 28 Aug 2002 17:28:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318982AbSH1V2C>; Wed, 28 Aug 2002 17:28:02 -0400
Date: Wed, 28 Aug 2002 22:32:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update ver_linux script to work with gcc 3.2.
Message-ID: <20020828223216.A13321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Cole <elenstev@mesatop.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1030569489.4032.113.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030569489.4032.113.camel@spc9.esa.lanl.gov>; from elenstev@mesatop.com on Wed, Aug 28, 2002 at 03:18:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 03:18:09PM -0600, Steven Cole wrote:
> --- linux-2.4.20-pre4-ac2/scripts/ver_linux.orig	Wed Aug 28 14:37:39 2002
> +++ linux-2.4.20-pre4-ac2/scripts/ver_linux	Wed Aug 28 14:37:51 2002
> @@ -12,7 +12,11 @@
>  uname -a
>  echo ' '
> 
> -echo "Gnu C                 " `gcc --version`
> +gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
> +'NR==1{print "Gnu C                 ", $1}'
> +
> +gcc --version 2>&1| grep gcc | awk \
> +'NR==1{print "Gnu C                 ", $3}'

Btw, both old and new versions are buggy here, as they should check $(CC).

My system compiler here is 2.95 but I compile with 3.2 from
/opt/gcc-3.2/bin/gcc

