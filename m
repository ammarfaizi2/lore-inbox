Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVDGSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVDGSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDGSK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:10:26 -0400
Received: from mail.aknet.ru ([217.67.122.194]:48655 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262548AbVDGSKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:10:10 -0400
Message-ID: <42557786.8090502@aknet.ru>
Date: Thu, 07 Apr 2005 22:10:14 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu> <42555BBF.6090704@aknet.ru> <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org> <425563D6.30108@aknet.ru> <Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Linus Torvalds wrote:
> The NMI code had better be really careful, and yeah, I suspect it needs 
> fixing.
And since the NMI return will need a
ESP fixup too, it will require the
"branched" version of the restore_all
checks I suppose.

>> 2. How can one be sure there are no more
>> of the like places where the stack is left
>> empty?
> That's a good argument, and may be the strongest reason for _not_ doing 
> the speculation.
I haven't said that explicitly, only
implied:) My another idea was to adjust
the tss.esp0 to always point 8 bytes below
the real top of the stack, so that even in
case of an NMI we are still safe. And in
case of another such instance - too.
This may look more like a hack than shifting
the "sti", but it is probably more reliable.
At least something to consider as soon as we
are at it.

