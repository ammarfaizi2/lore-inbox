Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTIWVMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTIWVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:12:10 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:56570 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263426AbTIWVMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:12:07 -0400
Date: Tue, 23 Sep 2003 14:22:07 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030923212207.GA25234@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The existing code in kernel/vsprintf.c:vsscanf() does not properly 
handle the case where the format is specfied as %x or %X and the
string contains the number in the format "0xinteger". Instead of
reading "0xinteger", the code currently only sees the '0' and treats
the 'x' as a delimiter. Following patch (against 2.4 and 2.6) fixes
this.  Another option is to put the check in simple_strtoul() and
simple_strtoull() if that is preferred. I like this better b/c
we only have the check once.

Please apply,
~Deepak

===== lib/vsprintf.c 1.2 vs edited =====
--- 1.2/lib/vsprintf.c	Mon Aug 11 04:54:01 2003
+++ edited/lib/vsprintf.c	Tue Sep 23 13:50:50 2003
@@ -615,6 +615,8 @@
 		case 'x':
 		case 'X':
 			base = 16;
+			if(str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
+				str += 2;
 			break;
 		case 'd':
 		case 'i':


-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
