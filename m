Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVA0I3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVA0I3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 03:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVA0I3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 03:29:24 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:45282 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262450AbVA0I3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 03:29:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NxwlY4Ejp6ZXhXwqmSC89Tt1IL0JOonOHw0A7HqO/v9DkIkxV9C0h8qMzntck5NqfVVLCycQe1f3G29TuCBkSdIDKbJcNC5oL5Mbg56wCFJBmXoTl39p0hdiK8yyHs+0wbExrmtWtnmKMYD3jMVT7FmiKHxRibteEqdvn20uxHw=
Message-ID: <81b0412b050127002965e21f74@mail.gmail.com>
Date: Thu, 27 Jan 2005 09:29:04 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Pavel Fedin <sonic_amiga@rambler.ru>
Subject: Re: [PATCH] Russian encoding support for MacHFS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050125123516.7f40a397.sonic_amiga@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
	 <81b0412b05012410463c7fd842@mail.gmail.com>
	 <20050125123516.7f40a397.sonic_amiga@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 12:35:16 +0300, Pavel Fedin <sonic_amiga@rambler.ru> wrote:
> > how about just leave the characters unchanged? (remap them to the same
> > codes in Unicode).
> 
>  But what to do when i convert then from unicode to 8-bit iocharset? This can lead to that several characters in Mac charset will be converted to the same character in Linux charset. This will lead to information loss and name will not be reverse-translatable.
>  To describe the thing better: i have 8-bit Mac encoding and 8-bit target encoding (iocharset). I need to convert from (1) to (2) and be able to convert back. I tried to perform a one-way conversion like in other filesystems but this didn't work.
>  Probably NLS tables can be used when iocharset is UTF8. If you wish i can try to implement it after some time.

remap unicode character missing in filesystem codepage into something like '?'.
I believe this is what nls routines do if converter returns -1 (error).
You'd loose the new characters, right. But you'd loose them anyway, as they
have no place in mac software.

> > Unicode, and its encoding UTF8 IS commonly used everywhere.
> > And Russia can (and often does) use it just as well.
> 
>  Many people say many software is not UTF8-ready yet. Anyway i had problems when tried to use it. Many russian ASCII documents use 8-bit encoding so i need to be able to deal with them. Many software assumes that 1 byte is 1 character.

just fix that software instead of polluting the kernel.

And besides: software which _does_ work with unicode,
can make a good use of an nls module for HFS.
