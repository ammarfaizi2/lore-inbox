Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTBIM1s>; Sun, 9 Feb 2003 07:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBIM1r>; Sun, 9 Feb 2003 07:27:47 -0500
Received: from dsl-213-023-050-177.arcor-ip.net ([213.23.50.177]:43705 "EHLO
	pulsar.homelinux.net") by vger.kernel.org with ESMTP
	id <S267259AbTBIM1p>; Sun, 9 Feb 2003 07:27:45 -0500
Message-ID: <3E464B14.5040004@pulsar.homelinux.net>
Date: Sun, 09 Feb 2003 13:35:32 +0100
From: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ENTRY-macro in linkage.h
References: <3E45358F.8020509@pulsar.homelinux.net> <1044752435.18908.23.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1044752435.18908.23.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My problem is how to add the whitespace. The preprocessor seems to strip 
it. Consider this (test.S):

#define ENTRY(X) \
  .global X##; \
X##:   

ENTRY(foo)
ENTRY(bar)

gcc -S test.S:

.global foo; foo:
.global bar; bar:

For c4x-gcc, this has to be like this:

    .global foo
foo:
    .global bar
bar:

Without the leading whitespace, .global is taken as a name of a label. 
Without the newline before the labels, they are not recognized (taken as 
comments).

How can I tell the preprocessor to emit spaces and newlines?

Alan Cox wrote:

>On Sat, 2003-02-08 at 16:51, Uwe Reimann wrote:
>  
>
>>Hi,
>>
>>I'm currently porting linux to TI's TMS320C31. I'm using c4x-gcc, which 
>>has a problem with the ENTRY-macro from linkage.h. c4x-gcc will accept 
>>the generated .globl-directive only if it is preceded by whitescape. 
>>Right know, gcc thinks I want to create a label called .globl. Any ideas 
>>how to fix this without fixing gcc?
>>    
>>
>
>I think every other port will probably be fine with the whitespace present
>so I guess add a space 8)
>
>
>
>  
>


