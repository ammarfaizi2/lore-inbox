Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277834AbRJLTqD>; Fri, 12 Oct 2001 15:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277836AbRJLTpx>; Fri, 12 Oct 2001 15:45:53 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:63751 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277834AbRJLTpq>; Fri, 12 Oct 2001 15:45:46 -0400
Message-Id: <200110121945.f9CJjX0V019814@pincoya.inf.utfsm.cl>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Matt Domsch <Matt_Domsch@dell.com> 
   of "Fri, 12 Oct 2001 14:11:23 EST." <Pine.LNX.4.33.0110121340140.17295-100000@lists.us.dell.com> 
Date: Fri, 12 Oct 2001 15:45:32 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <Matt_Domsch@dell.com> said:
> In trying to get my EFI GUID Partition Table patch included into the stock
> kernel, Andreas Dilger suggested it was time for some crc32 cleanup, as
> the GPT patch added yet another copy of the common crc32 function.  So,
> here's my first pass at it.  Comments welcome.

[...]

> This patch (appended below), makes include/linux/crc32.h and
> lib/crc32.c.  It generates a table based on the commonly used polynomial
> at init time provided a driver needs it.  It changes ether_crc_le() to use
> this table.  It renames the commonly seen ether_crc() to be
> ether_crc_be(), and puts it in crc32.h (allowing lots of copies to be
> deleted).

You could just place the functions (each with its table) into separate .c
files, and place them in the library. The linker will then include them iff
they are referenced somewhere. OTOH, they _are_ all over the place right
now, so they could just be included unconditionally. Thinking of ways to
set up to have them included in case only modules use them makes me
shiver...
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
