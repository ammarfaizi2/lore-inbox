Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVDFRI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVDFRI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVDFRI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:08:56 -0400
Received: from quark.didntduck.org ([69.55.226.66]:25003 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262228AbVDFRIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:08:54 -0400
Message-ID: <425417D5.20503@didntduck.org>
Date: Wed, 06 Apr 2005 13:09:41 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: LKML list <linux-kernel@vger.kernel.org>
Subject: Re: return value of ptep_get_and_clear
References: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
In-Reply-To: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> ptep_get_and_clear has a signature that looks something like:
> 
> static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
> long addr,
>                                        pte_t *ptep)
> 
> It appears that its suppose to return the pte_t pointed to by ptep 
> before its modified.  Why do we bother doing this?  The caller seems 
> perfectly able to dereference ptep and hold on to it.  Am I missing 
> something here?
> 
> If not, I'll work up a set of patches to change ptep_get_and_clear and 
> its callers for post 2.6.12 release.
> 
> - kumar

Because it is an atomic operation.  If you dereference it before 
ptep_get_and_clear() it could change in between.

--
				Brian Gerst
