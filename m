Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWAAP0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWAAP0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAAP0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:26:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35732 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751346AbWAAP0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:26:35 -0500
Date: Sun, 1 Jan 2006 16:26:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can setuid programs regain root after dropping it when using
 capabilities?
In-Reply-To: <dp6rea$kdh$1@taverner.CS.Berkeley.EDU>
Message-ID: <Pine.LNX.4.61.0601011626270.11226@yvahk01.tjqt.qr>
References: <20051129213545.6154ce37@TANG-FOUR-EIGHTY-ONE.MIT.EDU>
 <dp6rea$kdh$1@taverner.CS.Berkeley.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>While debugging some code, I found that a setuid program could regain
>>root after dropping root if the program used capabilities. (I tested
>>this on 2.6.14 and 2.6.9.) Is this the expected behavior? Here's a
>>short test case:
>>
>>/* chown root this program, suid it, and run it as non-root */
>>#include <sys/types.h>
>>#include <sys/capability.h>
>>#include <unistd.h>
>>#include <stdio.h>
>>int main() {
>>   cap_set_proc(cap_from_text("all-eip")); /* drop all caps */
>>   setuid(getuid());                       /* drop root. this call succeeds */
>>   setuid(0);                              /* this should fail! but doesn't */

uid != euid. You would probably have to use

  seteuid(getuid());

Plus there is also the feature of saved ids, see sys_setresuid().



Jan Engelhardt
-- 
