Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUA0J0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUA0J0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:26:04 -0500
Received: from gw2.cosmosbay.com ([195.115.130.129]:49867 "EHLO
	gw2.cosmosbay.com") by vger.kernel.org with ESMTP id S263015AbUA0J0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:26:01 -0500
Message-ID: <40162E9A.1080005@cosmosbay.com>
Date: Tue, 27 Jan 2004 10:25:46 +0100
From: dada1 <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.1 x86_64 : STACK_TOP and text/data
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com>
In-Reply-To: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Anybody knows why STACK_TOP is defined to 0xc0000000 in x86_64 ?

This means that stack allocated variables are all in the first 4GB 
quadrant in memory.
As the default virtual addresses of text/data of a programm are in this 
same quadrant, some programming errors could be undetected.
(Some programmers could still cast some pointers to 'unsigned int' for 
example, and this could 'work')

Tru64 has a different strategy :
Program text starts at 0x120000000
Program data starts at 0x140000000
Stack is just under text, but still not in the first 4GB quadrant.

This way, programmers errors are likely to be detected at dev time.

Another point is that BSS zone (heap) cannot exceed 3GB in x86_64 mode, 
since the brk hit the stack.
libc malloc then fallback to use a lot of arenas... suboptimal in terms 
of  vmas.

Strangely, in ia32 emulation mode, the stack is placed at the 4GB limit !

Thank you
Eric Dumazet

