Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTDWQqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTDWQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:46:43 -0400
Received: from mail.gmx.net ([213.165.65.60]:27512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264104AbTDWQqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:46:42 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Searching for string problems
Date: Wed, 23 Apr 2003 19:58:43 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304231958.43235.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

OK. I've solved my problems with storing data (problem was with improper DS 
setup - thanks to all, pointed me to this). And now I should perform a search 
in the BIOS are for particular string (version of BIOS ). Here is my code 
(it's located in the setup.S, so executes in the real mode, not ptotected).

-->
start_of_setup:
	jmp cl_start
cl_id_str:      .string "BIOS 0.1" 
cl_start:
        movb    $0, %al
        movw    $0xe000, %bx
cl_compare:
        incw    %bx
        movw    %bx, %si
        cmpw    $0xefff, %si
        je      cl_compare_done
        movw    $cl_id_str, %di
cl_compare_inner:
        movb    (%di), %ah
        cmpb    $0, %ah
        je      cl_compare_done_good
        cmpb    (%si), %ah
        jne     cl_compare
        incw    %si
        incw    %di
        jmp     cl_compare_inner
cl_compare_done_good:
        movb    $1, %al
cl_compare_done:
<--

This code don't work... I'm sure, that's because of inproper registers setup 
(or maybe address range is wrong). Please help me.

Best regards,
Andrew.
