Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTEBRBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEBRBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:01:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46481 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262873AbTEBRA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:00:56 -0400
Date: Fri, 2 May 2003 13:15:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Riley Williams <Riley@Williams.Name>
cc: Kevin Corry <kevcorry@us.ibm.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Bodo Rzany <bodo@rzany.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEBLCKAA.Riley@Williams.Name>
Message-ID: <Pine.LNX.4.53.0305021305250.9707@chaos>
References: <BKEGKPICNAKILKJKMHCAKEBLCKAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Riley Williams wrote:

> Hi Richard.
>
>  >>>>> IOW, %d _does_ mean base=10.  base=0 is %i.  That goes
>  >>>>> both for kernel and userland implementations of scanf
>  >>>>> family (and for any standard-compliant implementation,
>  >>>>> for that matter).
>
>  > What!??????
>  >
>  > The base, in the kernel code is the number that you divide by
>  > to return the remainder for numerical conversions!  the base
>  > is 8 or octal, 10 for decimal, 16 for hexadecimal, and up to
>  > 36 for some other strange unused thing (all 26 letters of the
>  > alphabet).
>
> If you read the definition of the scanf() family of functions, you
> will note that a base of 0 is used to indicate that the standard C
> prefixes should be honoured, such that a number beginning with 0x
> is read as hexadecimal, a number beginning with 0 is read as octal
> and any other number is read as decimal. As a result, the value of
> 0 for base IS valid but is special cased.
>
> Think of it like the code that reads from a file. When the end of
> the file is reached, the "character" EOF (code -1) is returned.
> Such is not a valid character in the normal sense of the word, but
> a special case that the function can produce.
>
>  > If your conversion chances the base to 0, you divide by 0 (not
>  > good) and don't get a remainder. Actually  procedure number()
>  > protects against a base less than 2 or greater than 36 so you
>  > just prevent conversion altogether.
>
> If your conversion puts the base as 0, the code says "ah, we don't
> know what base to use, so we look at the first few digits to decide"
> and follows the above rules. Not a problem.
>
> Best wishes from Riley.
> ---

The base, shown in the definition in scanf() does not have any
correlation to the names of the internal variables used. The
current code, correctly uses the base of 10 when %d, %u, %l, and
all the other decimal variants are encountered, and correctly
uses base octal when %o is encountered, and correctly uses
base 16 when %x or its variations are encountered. The only
known problem is not a problem with base, but a problem with
scanning  the string because the standard allows 0x to preceed
a hexadecimal number.

Kevin Corry <kevcorry@us.ibm.com>, submitted a patch which breaks
already working code in an aparent attempt to fix the leading
"0x" problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

