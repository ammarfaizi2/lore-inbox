Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUHSONd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUHSONd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUHSONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:13:33 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:2279 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S266213AbUHSOMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:12:50 -0400
Date: Thu, 19 Aug 2004 16:12:47 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Lei Yang <leiyang@nec-labs.com>
Cc: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lei Yang <leiyang@nec-labs.com>
Subject: Re: problem with fwrite
Message-ID: <20040819161247.4fa08389@phoebee>
In-Reply-To: <4124AE51.2060700@nec-labs.com>
References: <4124AE51.2060700@nec-labs.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__19_Aug_2004_16_12_47_+0200_OD20gvbGsrHM8hm8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__19_Aug_2004_16_12_47_+0200_OD20gvbGsrHM8hm8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 19 Aug 2004 09:42:41 -0400
Lei Yang <leiyang@nec-labs.com> bubbled:

> Hi all,
> 
> This is not really a kernel issue, apologize if anyone thinks that
> this is not the right place to post it. But I am writing a kernel
> module and got stuck on fwrite, really hope someone could point out
> what stupid mistake I've made. I wrote a very simple code to test the
> idea, what I really want to do in fred() is to read from 'dest' and
> write to 'src'. It seems that upon running , fgetc doesn't get
> anything from in_stream, so the first char it gets is an EOF and it
> breaks. Just why fwrite didn't write anything to in_stream?
> 
> If this is not the right way to do it, what is ?
> 
> Appreciate any comments, even harsh ones.

First: Wrong place!!!

> 
> TIA
> Lei
> 
> // in test.c
> 
> #include <stdio.h>
> 
> fred(char *dest, size_t *destlen, char *src, size_t size)
> {
>      FILE *in_stream = tmpfile();
>      FILE *out_stream = tmpfile();
>      fwrite(src, 1, size, in_stream);

Seek in_stream to 0 (rewind)! like:
       rewind(in_stream);

> 
>      int c, i;
>      for(i = 0;;i++)
>      {
>    	c = fgetc(in_stream);
>    	fprintf(stderr, "get char %c\n", c);

the fprintf of the read char should be after the EOF check!

> 	if ( c == EOF) break;
>    	fputc(c, out_stream);
>       }
> 
>      *destlen = i;
> 	
>      fseek(out_stream, 0, SEEK_SET); //rewind
>      fread(dest, 1, *destlen, out_stream);
>      fclose(in_stream);
>      fclose(out_stream);
>      fprintf(stderr, "buf = `%s', size = %d\n", dest, *destlen);
> }
> 
> int main(void)
> {
>    static char source[] = "really hope this works ";
> 
>    char *bp = malloc (2048);
>    size_t destlen;
> 
>    fred(bp, &destlen, source, strlen(source));
> 
>    fprintf(stderr, "buf = `%s', size = %d\n", bp, destlen);
>    return 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
MyExcuse:
Traffic jam on the Information Superhighway.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__19_Aug_2004_16_12_47_+0200_OD20gvbGsrHM8hm8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJLVfmjLYGS7fcG0RAkIjAKCh3QsARA3IEFdJ39qcgNGiGHzR4QCbBlx3
rgHO/+trgrzvCtx5vvT0+ZU=
=hc0P
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Aug_2004_16_12_47_+0200_OD20gvbGsrHM8hm8--
