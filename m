Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTDWTyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTDWTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:54:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264208AbTDWTyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:54:44 -0400
Date: Wed, 23 Apr 2003 13:05:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Kirilenko <icedank@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Message-Id: <20030423130531.0a7cbcc6.rddunlap@osdl.org>
In-Reply-To: <200304232248.35985.icedank@gmx.net>
References: <200304231958.43235.icedank@gmx.net>
	<200304232200.20028.icedank@gmx.net>
	<Pine.LNX.4.53.0304231529320.25963@chaos>
	<200304232248.35985.icedank@gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003 22:48:35 +0300 Andrew Kirilenko <icedank@gmx.net> wrote:

| Hello!
| 
| Big thanks to all of you. Now I'm starting to understand how it's working. 
| Here is current version of my code:
| 
| -->
|        jmp         cl_start
| cl_id_str:      .string "STRING"
| cl_start:
|         cld
|         movw    %cs, %ax
|         movw    %ax, %ds
|         movw    $0xe000, %ax
|         movw    %ax, %es
|         movb    $0, %al
|         xor         %bx, %bx  # start of segment
| cl_compare:
|         movw    $cl_id_str, %si
|         movw    $cl_start, %cx
|         subw    %si, %cx
|         decw    %cx
|         movw    %bx, %di
|         repz    cmpsb
|         je      cl_compare_done_good
|         incw    %bx
|         cmpw    $0xffff, %bx  # are we at the end of segment
|         je      cl_compare_done
|         jmp     cl_compare
| cl_compare_done_good:
|        movb $1, %al
| cl_compare_done:

# here the code needs to do something like this,
# to check the second 64 KB block of memory:
	movw	%es, %bx
	cmpw	%bx, $0xe000
	je	all_done
	movw	$0xf000, %bx
	movw	%bx, %es
	xor	%bx, %bx
	jmp	cl_compare


| <--
| 
| And this code won't work as well :(

Do you understand x86 real-mode segment registers?
They can only address a "segment" of 64 KB (roughly).

| Unfortunately, I can't start DOS and check, cause there is no video and 
| keyboard controller on that PC.

oh yes.

--
~Randy
