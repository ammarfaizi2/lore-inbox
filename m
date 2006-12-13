Return-Path: <linux-kernel-owner+w=401wt.eu-S932616AbWLMIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWLMIi3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWLMIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:38:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37757 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbWLMIi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:38:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xhh12mTqeF4IYWuqC2dqMEQcrJjgbTWYfH4M7Z1GJOe8gzPlBVMSZFtUDWD3eZax3HL6bF5k+WvgxIEHQom7ecPQW+Ycb1qdusRkvDxmmJZqEwaJSU75eF+ayxRN/0LFlw4v1mL20Eryy/sUms/diYKiBMGBUpEBScMFnJgOy5E=
Message-ID: <cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
Date: Wed, 13 Dec 2006 09:38:26 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,mm: hecuba/E-Ink fbdev driver v2
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	 <457D895D.4010500@innova-card.com>
	 <45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> I think that PTEs set up by vmalloc are marked cacheable and via the
> above nopage end up as cacheable. I'm not doing DMA. So the accesses
> are through the cache so I don't think cache aliasing is an issue for
> this case. Please let me know if I misunderstood.
>

This issue is not related to DMA: there are 2 different virtual
addresses that can map the same physical address. If these 2 virtual
addresses use 2 different data cache entries then you have a cache
aliasing issue. In your case the 2 different virtual addresses are (1)
the one got by the kernel (returned by vmalloc) (2) the one got by the
application (returned by mmap).

Hope that helps.
-- 
               Franck
