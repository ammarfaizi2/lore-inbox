Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281981AbRKUVWS>; Wed, 21 Nov 2001 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281984AbRKUVWJ>; Wed, 21 Nov 2001 16:22:09 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:48118 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281981AbRKUVVy>; Wed, 21 Nov 2001 16:21:54 -0500
Date: Wed, 21 Nov 2001 16:21:28 -0500
From: Ben Collins <bcollins@debian.org>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asm style
Message-ID: <20011121162128.E363@visi.net>
In-Reply-To: <01112123070300.05447@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01112123070300.05447@manta>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:07:03PM +0000, vda wrote:
> I'm using GCC 3.0.1 and seeing "multi-line literals are deprecated".
> Since a patch is necessary for that (and someone submitted it already)
> I'd like to hear from big kernel guys what asm statement style to use:
> 	asm(
> "		cmd	r,r\n"
> "lbl:		cmd	r,r\n"
> "		cmd	r,r\n"
> 		: spec
> 		: spec
> 	);
> [variable width for labels? I don't like it] or
> 	asm(
> 	"	cmd	r,r\n"
> 	"lbl:	cmd	r,r\n"
> 	"	cmd	r,r\n"
> 		: spec
> 		: spec
> 	);
> [better. But \n's are ugly] or
> #define NL "\n"
> 	asm(
> 	"	cmd	r,r" NL
> 	"lbl:	cmd	r,r" NL
> 	"	cmd	r,r" NL
> 		: spec
> 		: spec
> 	);

There's also:

	asm("\
	cmd	r,r\n\
lbl:	cmd	r,r\n\
	cmd	r,r\n" : spec : spec);


Or something similar (the trailing "\" added for continuation). Probably
the easiest way to patch existing asm.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
