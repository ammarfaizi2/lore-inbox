Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKKX45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKKX45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVKKX45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:56:57 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:5901 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVKKX45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:56:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uhpUghQPVqJpMeiBG2U7wbHrJTL2JL5Wl0rZsqQtr1m35etZTgLy7JNyL7UeJjpZhlX9u3qNousCwz3fwoVc0bOjCtMcP/DOdZI3mQCnMjvII10cojfr/G03QjZZxBVOCv48fRkQhgXxREfPtKXdZ4/MSHsnTIWIj2uMyanN3D4=
Message-ID: <43752F82.1010004@gmail.com>
Date: Sat, 12 Nov 2005 07:55:46 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH] nvidiafb: Fix bug in nvidiafb_pan_display
References: <20051110203544.027e992c.akpm@osdl.org>	 <6bffcb0e0511111432m771dcda2y@mail.gmail.com>	 <20051111150108.265b2d3f.akpm@osdl.org>  <4375291F.3040508@gmail.com> <1131752304.24637.260.camel@gaston>
In-Reply-To: <1131752304.24637.260.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Sat, 2005-11-12 at 07:28 +0800, Antonino A. Daplas wrote:
>> nvidiafb_pan_display() is incorrectly using the fields in
>> info->var instead of var passed to the function.
> 
> Shouldn't it also update info->var is is this done by the core ?
> 

Nobody calls or should call fbops->fb_pan_display() directly except
the wrapper fb_pan_display() in fbmem.c.  It already does the checking
and the update to info->var. So checking and updating for the offsets
will be redundant.

Tony
