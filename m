Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264810AbUDWNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbUDWNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbUDWNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:50:16 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:30620 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264811AbUDWNuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:50:11 -0400
Date: Fri, 23 Apr 2004 23:28:51 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Pavel Machek" <pavel@ucw.cz>
Subject: Re: SOFTWARE_SUSPEND as a module
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz> <20040423093836.GA10550@gondor.apana.org.au>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr6wvqddzruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <20040423093836.GA10550@gondor.apana.org.au>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 23 Apr 2004 19:38:36 +1000, Herbert Xu  
<herbert@gondor.apana.org.au> wrote:
> What I've done is:
>
> * Split swsusp.c into swsusp-core.c and the rest based on whether it
> is called by do_magic() or not.
> * Added EXPORTs for the symbols needed by what's left of swsusp.
> * Added module parameter parsing.

Do you really need to make suspend a module to achieve this? I'll freely  
admit it might be nice to save a little bit of memory by modularising it,  
and it might save Pavel and I a reboot or two while developing, but for  
what you're after, couldn't you just move the call that starts resuming?

> As a side-effect it also allows you to resume from devices that couldn't
> be done before due to the need for user-space setup.  Examples are LVM
> and NBD.

LVM can be compiled in, can't it? Does it need to do some setup from an  
initrd?

>> prepared for it in userland? In such case you need to add
>> freeze_processes() to resume path.
>
> Is that really necessary if the user-space caller ensures that all
> disk accesses are shut down? After all the loading for resume will
> occur in the initrd before any disk activity has occured.

So long as the initrd doesn't mount any filesystems that were suspended,  
you should be okay, IIRC.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
