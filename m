Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKNOyG>; Tue, 14 Nov 2000 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129514AbQKNOx4>; Tue, 14 Nov 2000 09:53:56 -0500
Received: from hermes.mixx.net ([212.84.196.2]:60174 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129130AbQKNOxz>;
	Tue, 14 Nov 2000 09:53:55 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Modprobe local root exploit
Date: Tue, 14 Nov 2000 15:23:50 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A114AF6.44AA8032@innominate.de>
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de> <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com> <14864.6812.849398.988598@ns.caldera.de> <20001113134630.C18203@wire.cadcamlab.org> <news2mail-3A112225.F29226B6@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974211825 11965 10.0.0.90 (14 Nov 2000 14:23:45 GMT)
X-Complaints-To: news@innominate.de
Cc: David Relson <relson@osagesoftware.com>,
        Peter Samuelson <peter@cadcamlab.org>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, David Relson wrote:
> At 06:29 AM 11/14/00, Daniel Phillips wrote:
> 
> >Heading in the right direction, but this is equivalent to:
> >
> >   if (isalnum(*p) && *p != '-' && *p != '_') return -EINVAL;
> >
> >which is faster, smaller and easier to read.
> 
> Almost right, but you forgot to negate isalnum().  Should be:
> 
>          if (!isalnum(*p) && *p != '-' && *p != '_') return -EINVAL;
> 
> or
>          if (! (isalnum(*p) || *p == '-' || *p == '_')) return -EINVAL;
> 
> I think I prefer the older version with "continue" as I don't have to think 
> about all the negatives ("!"), i.e.
> 
>          for ( ... )
>          {
>                  if ( isalnum(*p) || *p == '-' || *p == '_' )
>                          continue;
>                  return -EINVAL;
>          }
> 

I reserve the right to make coding errors, thanks for not letting it get
written into history :-)

How about:

  for ( ... ) if (!isalnum(*p) && !strchr("-_", *p)) return -EINVAL;

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
