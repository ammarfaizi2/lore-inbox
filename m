Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbUKPVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbUKPVgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKPVeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:34:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35267 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261828AbUKPVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:33:20 -0500
Date: Tue, 16 Nov 2004 22:33:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: A M <alim1993@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing program counter registers from within C or Aseembler.
In-Reply-To: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0411162228440.20331@yvahk01.tjqt.qr>
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>Does anybody know how to access the address of the
>current executing instruction in C while the program
>is executing?

With the aid of a second program, yes.
For one program: not directly. It's because the EIP changes while you are
calclating it.
You could f.e.:

int main(void) {

    printf("owned\n");
mark:
    printf("pwned\n");
    printf("%p\n", &&mark);
}

GCC specific.
Or you could also poke around with __builtin_return_address, or even peek at
the stack yourself.

>Also, is there a method to load a program image from
>memory not a file (an exec that works with a memory
>address)? Mainly I am looking for a method that brings
>a program image into memory modify parts of it and
>start the in-memory modified version.

No, because that opens a wide door for trojans and stack smashers.

>Can anybody think of a method to replace a thread
>image without replacing the whole process image?

It would not be a thread then.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
