Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313569AbSDHGhN>; Mon, 8 Apr 2002 02:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSDHGhM>; Mon, 8 Apr 2002 02:37:12 -0400
Received: from rj.SGI.COM ([204.94.215.100]:57807 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313569AbSDHGhK>;
	Mon, 8 Apr 2002 02:37:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: marcelo@conectiva.com.br,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Extraversion in System.map? 
In-Reply-To: Your message of "Mon, 08 Apr 2002 15:29:47 +0900."
             <Pine.LNX.4.44.0204081526200.548-100000@holly.crl.go.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 16:36:56 +1000
Message-ID: <595.1018247816@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002 15:29:47 +0900 (JST), 
Tom Holroyd <tomh@po.crl.go.jp> wrote:
>On Mon, 8 Apr 2002, Keith Owens wrote:
>
>> System.map only contains the numeric kernel version.  After all, it is
>> difficult to convert 2.4.19-pre6 to Version_132115-pre6 when symbols
>> cannot contain '-'.
>
>Well, that has an obvious solution, but modifying the Version string
>would likely break something.  Adding another string would work.  It
>could even be done without making the kernel image bigger.  In fact,
>the Version_* symbol (and Extraversion_* symbol) could both be made
>__initdata, couldn't they?

Where the symbol's content is placed is irrelevant.  System.map
contains the symbol _name_, not its _contents_.  But symbol names
cannot contain the special characters that people put in extraversion.
Even mapping the special characters to '_' will not help because a lot
of people do not change extraversion when changing config and the
change of config can really move symbols around.  Hence all the checks
that ksymoops does to validate symbol addresses between multiple
sources.

I have some ideas about making System.map and the kernel record which
build they refer to, including the .config data.  But that is 2.5
material, after kbuild 2.5 goes in.

