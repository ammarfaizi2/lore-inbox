Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288233AbSAMWh5>; Sun, 13 Jan 2002 17:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288234AbSAMWhs>; Sun, 13 Jan 2002 17:37:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41988 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288233AbSAMWhi>; Sun, 13 Jan 2002 17:37:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs buffer spec -- third draft
Date: 13 Jan 2002 14:37:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1t270$nq0$1@cesium.transmeta.com>
In-Reply-To: <1010958148.8691.0.camel@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1010958148.8691.0.camel@voyager>
By author:    Norbert Kiesel <nkiesel@tbdnetworks.com>
In newsgroup: linux.dev.kernel
>
> 
> --=-9GEMJ19dnS3OnVEuQ1tM
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> H. Peter Anvin wrote:
> >               initramfs buffer format
> >               -----------------------
> >
> >               Al Viro, H. Peter Anvin
> >              Last revision: 2002-01-13
> >
> >       ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT **
> .....
> >The full format of the initramfs buffer is defined by the following
> >grammar, where:
> >    *    is used to indicate "0 or more occurrences of"
> >    (|)    indicates alternatives
> >    +    indicates concatenation
> >    GZIP()    indicates the gzip(1) of the operand
> >    ALGN(n)    means padding with null bytes to an n-byte boundary
> >
> >    initramfs  :=3D ("\0" | cpio_archive | cpio_gzip_archive)*
> >
> >    cpio_gzip_archive :=3D GZIP(cpio_archive)
> >
> >    cpio_archive :=3D cpio_file* + (<nothing> | cpio_trailer)
> >
> >    cpio_file :=3D ALGN(4) + cpio_header + filename + "\0" + ALGN(4) +
> data
> >
> >    cpio_trailer :=3D ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)
> 
> 
> what's the purpose of the "*" behind cpio_file in the cpio_archive
> definition?  There is already repetition in the initramfs and the "*"
> behind cpio_archive would e.g. allow a sequence of cpio_trailers
> without  any cpio_file inbetween.
> 

Allow GZIP(cpio_file* + cpio_trailer), which is in fact a very common
configuration.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
