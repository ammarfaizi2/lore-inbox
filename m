Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUFBRyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUFBRyC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFBRyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:54:02 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:18451 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263777AbUFBRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:53:22 -0400
Message-ID: <40BE173B.7090005@techsource.com>
Date: Wed, 02 Jun 2004 14:06:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: =?UTF-8?B?57+9IERlamVhbg==?= <TazForEver@free.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kfree calls cleanup
References: <1085408263.26813.4.camel@athlon>
In-Reply-To: <1085408263.26813.4.camel@athlon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Benoît Dejean wrote:
> i've removed some useless test for NULL pointer before kfree calls.
> if(p) kfree(p) -> kfree(p)
> i've also removed variables that have become unused.
> the patch is quite big, but i've check it many times.


This is valid since kfree checks for null pointer, but while the extra 
"if (p)" is redundant, if p is most often NULL somewhere, then you can 
avoid the function call overhead by this very low-cost check.  (Unless 
kfree is a macro which includes the check in the macro.)

