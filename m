Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUESLBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUESLBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUESLBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:01:06 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:6633 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263585AbUESLBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:01:03 -0400
Date: Wed, 19 May 2004 13:00:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: more s390 patches for 2.6.6.
Message-ID: <20040519110055.GA5888@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I found the problem that caused s390 to hang on boot. The find_idlest_cpu
function triggers a bug in the find bit functions of s390. An address
passed to an inline assembly constraint doesn't force the content of
the memory pointed to by the address to be up-to-date. In the case of
find_idlest_cpu the compiler didn't bother to store to the memory
location of the bitfield input for find_first_bit/find_next_bit
because only the address of the bitfield has been passed to the inline
assembly but not the memory content of the bitfield. Uli explained to
me how an arbitrary large piece of memory can be "passed" to an inline
assembly. Looks strange but it works.
While I'm at it I sent the other accrued patches as well.

1) s390 core changes.
2) network driver fixes, add direct SNMP interface to qeth.
3) zfcp host adapter fix & cleanup.
4) dasd driver fix.

Patches apply against BitKeeper.

blue skies,
  Martin.
