Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129984AbQKNMAQ>; Tue, 14 Nov 2000 07:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbQKNMAG>; Tue, 14 Nov 2000 07:00:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:11270 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129984AbQKNL7x>;
	Tue, 14 Nov 2000 06:59:53 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Modprobe local root exploit
Date: Tue, 14 Nov 2000 12:29:41 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A112225.F29226B6@innominate.de>
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de> <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com> <14864.6812.849398.988598@ns.caldera.de> <20001113134630.C18203@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974201377 8652 10.0.0.90 (14 Nov 2000 11:29:37 GMT)
X-Complaints-To: news@innominate.de
To: Peter Samuelson <peter@cadcamlab.org>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Torsten Duwe]
> > >>>>> "Francis" == Francis Galiegue <fg@mandrakesoft.com> writes:
> >
> >     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> >
> >     Francis> Just in case... Some modules have uppercase letters too :)
> >
> > That's what the &0xdf is intended for...
> 
> It's wrong, then: you've converted to uppercase, not lowercase.
> 
> request_module is not a fast path.  Do it the obvious, unoptimized way:
> 
>   if ((*p < 'a' || *p > 'z') &&
>       (*p < 'A' || *p > 'Z') &&
>       (*p < '0' || *p > '9') &&
>       *p != '-' && *p != '_')
>     return -EINVAL;

Heading in the right direction, but this is equivalent to:

  if (isalnum(*p) && *p != '-' && *p != '_') return -EINVAL;

which is faster, smaller and easier to read.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
