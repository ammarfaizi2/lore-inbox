Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVL2Ps0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVL2Ps0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVL2PsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:48:25 -0500
Received: from vvv.conterra.de ([212.124.44.162]:10201 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1750767AbVL2PsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:48:25 -0500
Message-ID: <43B40541.20107@conterra.de>
Date: Thu, 29 Dec 2005 16:48:17 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: X86_64 compile error (crash.c)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this on 2.6.15-rc7 but it was on linux-2.6.14 already:

   CC      arch/x86_64/kernel/crash.o
In file included from include/asm/kexec.h:5,
                  from include/linux/kexec.h:9,
                  from arch/x86_64/kernel/crash.c:15:
include/asm/proto.h:66: error: syntax error before "cpu_initialized"
include/asm/proto.h:66: warning: type defaults to `int' in declaration of `cpu_initialized'
include/asm/proto.h:66: warning: data definition has no type or storage class
gmake[1]: *** [arch/x86_64/kernel/crash.o] error 1


#include <linux/cpumask.h> might be included in "asm-x86_64/proto.h"

however, it happens only with a very unusual configuration:

CONFIG_X86_64=y
CONFIG_KEXEC=y
CONFIG_COMPAT=n

else linux/cpumask.h gets included somewhere else...

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
