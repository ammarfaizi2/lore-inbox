Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWAQKmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWAQKmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWAQKmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:42:54 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:63941 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932370AbWAQKmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:42:54 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Arjan van de Ven <arjan@infradead.org>
cc: Akinobu Mita <mita@miraclelinux.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH 0/4] compact call trace 
In-reply-to: Your message of "Tue, 17 Jan 2006 11:31:27 BST."
             <1137493887.3005.21.camel@laptopd505.fenrus.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jan 2006 21:42:52 +1100
Message-ID: <10265.1137494572@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven (on Tue, 17 Jan 2006 11:31:27 +0100) wrote:
>On Tue, 2006-01-17 at 19:13 +0900, Akinobu Mita wrote:
>> These patches will:
>> 
>> - break the various custom oops-parsers which people have written themselves.
>> - use common call trace format on x86-64.
>> - change offset format from hexadecimal to decimal in print_symbol()
>> - delete symbolsize in call trace in print_symbol().
>> - print system_utsname.version in oops so that we can doing a
>>   double check that the oops is matching the vmlinux we're looking at.
>
>
>at least then make the kallsyms lookup mark up the string somehow (say
>by putting a * in front of it) if the EIP is outside the size of the
>symbol; so that we can spot garbage better.

There is no such thing as "outside the size of the symbol".  kallsyms
does not save symbol size, it is calculated as the difference between
this symbol and the next one in the table.  By definition, every size
is correct - as long as all symbols are in the table.

Some symbols are omitted from kallsyms, which makes the calculation of
"symbol size" wrong for some symbols, those symbols appear bigger than
they really are.  Printing the symbol size was done years ago as a hint
to the reader, it told them what the kernel thought the symbol size was
and gave them something to check against.  That was when there were
very few symbols in the kernel, so most size calculations were wrong.
Nowadays it is probably irrelevant.

