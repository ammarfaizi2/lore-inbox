Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDMLYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDMLYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVDMLYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:24:07 -0400
Received: from [195.23.16.24] ([195.23.16.24]:14550 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261316AbVDMLYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:24:02 -0400
Message-ID: <425D0144.9070207@grupopie.com>
Date: Wed, 13 Apr 2005 12:23:48 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] create a kstrdup library function
References: <42519911.508@grupopie.com>
In-Reply-To: <42519911.508@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Hi,
> 
> This patch creates a new kstrdup library function and changes the 
> "local" implementations in several places to use this function.

Arkadiusz Miskiewicz reported that this breaks compilation under PPC.

Apparently, PPC builds a bootloader that links against lib.a but doesn't 
expect any dependencies on slab. Since kstrdup calls kmalloc, this 
breaks compilation.

I can fix this by moving kstrdup into slab.c. This way this is treated 
as an "allocation" function instead of a string function, so it makes 
some sense to do this.

Andrew, do you prefer an incremental patch against the current tree, or 
a single clean patch against the current tree with all the current 
kstrdup patches taken out?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
