Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTDWTg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTDWTg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:36:58 -0400
Received: from pop.gmx.net ([213.165.64.20]:5554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263574AbTDWTgf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:36:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Date: Wed, 23 Apr 2003 22:48:35 +0300
User-Agent: KMail/1.4.3
References: <200304231958.43235.icedank@gmx.net> <200304232200.20028.icedank@gmx.net> <Pine.LNX.4.53.0304231529320.25963@chaos>
In-Reply-To: <Pine.LNX.4.53.0304231529320.25963@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304232248.35985.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Big thanks to all of you. Now I'm starting to understand how it's working. 
Here is current version of my code:

-->
       jmp         cl_start
cl_id_str:      .string "STRING"
cl_start:
        cld
        movw    %cs, %ax
        movw    %ax, %ds
        movw    $0xe000, %ax
        movw    %ax, %es
        movb    $0, %al
        xor         %bx, %bx  # start of segment
cl_compare:
        movw    $cl_id_str, %si
        movw    $cl_start, %cx
        subw    %si, %cx
        decw    %cx
        movw    %bx, %di
        repz    cmpsb
        je      cl_compare_done_good
        incw    %bx
        cmpw    $0xffff, %bx  # are we at the end of segment
        je      cl_compare_done
        jmp     cl_compare
cl_compare_done_good:
       movb $1, %al
cl_compare_done:
<--

And this code won't work as well :(

Unfortunately, I can't start DOS and check, cause there is no video and 
keyboard controller on that PC.

Best reagrds,
Andrew.

