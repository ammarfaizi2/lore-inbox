Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUBSToq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUBSTop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:44:45 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:39913 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267503AbUBSTon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:44:43 -0500
Message-ID: <40351211.1030200@colorfullife.com>
Date: Thu, 19 Feb 2004 20:44:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
References: <Pine.GSO.4.58.0402191527030.18841@Juliusz> <20040219145331.B23685@infradead.org> <20040219190720.GA2421@mars.ravnborg.org>
In-Reply-To: <20040219190720.GA2421@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>Maybe something like:
>mqueue.h	for kernel-only
>mqueue_abi.h	for kernel+user
>  
>
I don't think that this is necessary. Everything in <linux/> is kernel 
only. user space should copy the headers and remove the kernel only 
parts. kernel+user files mean that it's not possible rename structures 
or move them around. Perhaps someone wants to move all 16-bit uid 
structures into a <linux/compat/> directly - shared headers make that 
impossible.

I agree that the placement of the #ifdef is a bit arbitrary - it's a 
hint that the structures outside are visible to user space and must 
remain unchanged.

Christoph: I'm sure there will be users that must call the message queue 
functions directly from C code. E.g. the 32-bit emulation layers on 
64/32 bit archs. And they need the prototypes.

--
    Manfred

