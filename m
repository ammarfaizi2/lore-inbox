Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUHLVjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUHLVjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268788AbUHLVjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:39:12 -0400
Received: from everest.2mbit.com ([24.123.221.2]:28605 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S268800AbUHLV2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:28:52 -0400
Message-ID: <411BE105.4080203@greatcn.org>
Date: Fri, 13 Aug 2004 05:28:37 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sam@ravnborg.org
CC: kai@tp1.ruhr-uni-bochum.de, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <411B31A5.70508@greatcn.org>    <20040812172307.GA7365@mars.ravnborg.org>    <411BCE4F.1060002@greatcn.org> <51248.194.237.142.13.1092343524.squirrel@194.237.142.13>
In-Reply-To: <51248.194.237.142.13.1092343524.squirrel@194.237.142.13>
X-Scan-Signature: ce21113bd12aaf7d53962de4c3292a8b
X-SA-Exim-Connect-IP: 218.24.171.72
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Remove wildcard on KBUILD_OUTPUT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.171.72 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sam@ravnborg.org wrote:

>>You misunderstood me.
>>This patch removes unnecessary wildcard on KBUILD_OUTPUT and unused VPATH.
>>If it looks ok, I'd like to send it to lkml and akpm.
>>    
>>
>
>Try building a kernel where you use O= to specify another output directory.
>Try with an existing and a non-existing directory.
>
>You will see why both are needed.
>
>  
>

I searched VPATH in the manual. I was wrong on removing VPATH.
But I still think wildcard is unnecessary.

I did build kernel with another output directory, both existing and 
non-existing before mailling you.
And even when KBUILD_OUTPUT contains wildcard. Ok, I just saw Kai's 
reply. I Needn't further explain.


Kai Germaschewski wrote:

>>Try building a kernel where you use O= to specify another output directory.
>>Try with an existing and a non-existing directory.
>>    
>>
>
>I suspect that the patch works, if $(shell ...) returns what's written to 
>stdout, KBUILD_OUTPUT would be empty and thus the wildcard unnecessary. Of 
>course I'm too lazy to test it out, too...
>
>--Kai
>
>
>  
>


Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

--- linux-2.6.8-rc4-mm1/Makefile	2004-08-12 13:59:10.000000000 -0500
+++ linux-2.6.8-rc4-mm1-cy/Makefile	2004-08-12 16:09:08.171039406 -0500
@@ -102,7 +102,7 @@ ifneq ($(KBUILD_OUTPUT),)
 # check that the output directory actually exists
 saved-output := $(KBUILD_OUTPUT)
 KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT) && /bin/pwd)
-$(if $(wildcard $(KBUILD_OUTPUT)),, \
+$(if $(KBUILD_OUTPUT),, \
      $(error output directory "$(saved-output)" does not exist))
 
 .PHONY: $(MAKECMDGOALS)


-- 

Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

