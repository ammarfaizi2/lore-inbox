Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVHPDdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVHPDdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVHPDdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:33:41 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14340 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965086AbVHPDdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:33:40 -0400
Message-ID: <43015E8E.5020105@vmware.com>
Date: Mon, 15 Aug 2005 20:33:34 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com> <43015894.1090307@didntduck.org>
In-Reply-To: <43015894.1090307@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 03:33:35.0164 (UTC) FILETIME=[485697C0:01C5A213]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> If you really want to test the math emu code, you can hack check_x87 
> in head.S to always leave the fpu disabled.  Then you can test it on 
> any cpu, not just a 386. 


That is a good idea, and while a valid point, it actually still requires 
writing the code to actually test the FPU, specifically, using weird 
prefixes, LDT based segments, and other oddities that don't get 
generated from "normal" C code.  I'm pretty sure the existing code works 
for the 99% cases or else it wouldn't have gotten there in the first 
place.  But testing the corner cases here is even nastier than testing 
the LDT corner cases - you would basically need to write a lot of hand 
coded i387 assembler.  Perhaps such a test might exist, but in all 
honesty, without a comprehensive test, it is simply far too easy to 
introduce a bug here, and far too likely it will either not be noticed 
until it has caused someone a possibly undetected numerical error, or 
I'm just wasting my time because noone is using this code anyways.  
Fortunately, the Hubble telescope has been upgraded to a 486 ;)

Zach
