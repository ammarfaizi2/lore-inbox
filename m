Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVAaPDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVAaPDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVAaPDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:03:05 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63469 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261227AbVAaPDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:03:02 -0500
Message-ID: <41FE4876.8020507@nortelnetworks.com>
Date: Mon, 31 Jan 2005 09:02:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oded Shimon <ods15@ods15.dyndns.org>
CC: Miles Sabin <miles@milessabin.com>, linux-kernel@vger.kernel.org
Subject: Re: Pipes and fd question. Large amounts of data.
References: <200501301115.59532.ods15@ods15.dyndns.org> <200501300941.45554.miles@milessabin.com> <200501301248.45538.ods15@ods15.dyndns.org>
In-Reply-To: <200501301248.45538.ods15@ods15.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oded Shimon wrote:
> On Sunday 30 January 2005 11:41, Miles wrote:

>>I'd say that this was one of the rare cases where a solution using
>>threads is not only superior to one using event-driven IO, but actually
>>required.

> Yeah, I reached just about the same conclusion. At first I thought only 2 
> threads were necessary, one for each data flow, but I realized a deadlock 
> could happen just as well in that too. Making a 4 thread implementation I 
> trust is gonna be hard... I better get working. :)

Your other option would be to use processes with shared memory (either 
sysV or memory-mapped files).  This gets you the speed of shared memory 
maps, but also lets you get the reliability of not sharing your entire 
memory space.

If you use NPTL, your locking should be quick as well.  If not, you can 
always roll your own futex-based locking.

Chris
