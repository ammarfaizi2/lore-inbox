Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbQKFTyl>; Mon, 6 Nov 2000 14:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQKFTyb>; Mon, 6 Nov 2000 14:54:31 -0500
Received: from [64.64.109.142] ([64.64.109.142]:22282 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129350AbQKFTyV>; Mon, 6 Nov 2000 14:54:21 -0500
Message-ID: <3A070BEF.7712DEDB@didntduck.org>
Date: Mon, 06 Nov 2000 14:52:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: forop066@zaz.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: Calling module symbols from inside the kernel !
In-Reply-To: <200011061924.QAA31314@srv1-for.for.zaz.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forop066@zaz.com.br wrote:
> 
> Is it possible to access symbols exported by modules from inside the kernel ?
> 
> I put a funtion call inside the kernel code but this funtion must be implemented in a module. I tried export as a module symbol but when i tried to recompile the kernel.. :-(
> 
> Warning: implicit declaration of my_funtion
> .
> .
> .
> Error: Undefined reference to my_funtion.
> 
> How can i fix this mistake!????
> 
> Thanks in advance,
> Cris Amon.

You will need to use a function pointer hook that the module fills in
when it is loaded.  For an example look at devpts_upcall_new and
devpts_upcall_kill in fs/devpts/inode.c.  The hooks are resident in the
kernel and are exported so the module can see them.  The caller then
needs to check if the hook is null and optionally request the module be
loaded.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
