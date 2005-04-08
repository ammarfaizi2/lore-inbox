Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVDHXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDHXKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDHXKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:10:45 -0400
Received: from mail.hypersurf.com ([209.237.0.6]:34575 "EHLO
	mail.hypersurf.com") by vger.kernel.org with ESMTP id S261189AbVDHXKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:10:33 -0400
Message-ID: <42570EB3.3000905@hypersurf.com>
Date: Fri, 08 Apr 2005 16:07:31 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i486; en-US; rv:1.7b) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Kevin Diggs <kevdig@hypersurf.com>
Subject: 2.4.25+ ppc32 "make xconfig" error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	The make xconfig command spits out the following error (warning):

ERROR - Attempting to write value for unconfigured variable 
(CONFIG_ALTIVEC).

This is on a PowerMac 8600 running YellowDog 2.1.

Commenting the VMX thing for the Power4 in arch/ppc/config.in fixes the 
problem:

[kevdig@PowerMac8600B ppc]$ diff -U 3 config-{old,new}_in
--- config-old_in       Thu Apr  7 22:25:11 2005
+++ config-new_in       Fri Apr  8 15:56:32 2005
@@ -176,9 +176,9 @@
    fi
    define_bool CONFIG_PPC_ISATIMER y
  fi
-if [ "$CONFIG_POWER4" = "y" ]; then
-  bool 'VMX (same as AltiVec) support' CONFIG_ALTIVEC
-fi
+#if [ "$CONFIG_POWER4" = "y" ]; then
+#  bool 'VMX (same as AltiVec) support' CONFIG_ALTIVEC
+#fi

  if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
    bool 'Math emulation' CONFIG_MATH_EMULATION

This problem also prevents you from enabling AltiVec (UI unresponsive).

					kevin
