Return-Path: <linux-kernel-owner+w=401wt.eu-S1751539AbXAHN4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbXAHN4V (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXAHN4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:56:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:35788 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXAHN4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:56:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h1Grl3udHiD9BKWg2WfBHe4kR6xL88VxzjwbYPsvWR8d6s8sH9NQILSZeH+qrMnFaOJylrws001fATbh9FuKoSWzP1UJUpAJgbWNSP6hJMhLa/aGezoRA/NUNm7grULKxT2iiqhiZ57lpKoe+9WKhVHzuD6cu1x/rU7LrHLUHCU=
Message-ID: <45A24D1A.7020004@gmail.com>
Date: Mon, 08 Jan 2007 14:54:34 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH UPDATED 2.6.20-rc3] Remove all the unneeded k[mzc]alloc
 casts
References: <20070105102623.GB382@Ahmed> <200701081310.46547.eike-kernel@sf-tec.de>
In-Reply-To: <200701081310.46547.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2007 01:10 PM, Rolf Eike Beer wrote:

> Ahmed S. Darwish wrote:

>> -		struct intmem_allocation* alloc =
>> -		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
>> +		struct intmem_allocation* alloc = kmalloc(sizeof *alloc,
>> +							  GFP_KERNEL);
> 
> sizeof(*alloc) (see Documentation/CodingStyle)

Please do not advice that. The CodingStyle document only says "are 
usually used with parentheses in Linux, although they are not required 
in the language", nothing more. While for the most part a personal style 
issue, there are reasons for using "sizeof *ptr":

-- sizeof is not a function but an operator: you don't write
    "if (!(i))" or -(5) either.

-- it's usually "better" to sizeof the variable then it is to sizeof the
    type since it makes the code resistant to type changes (for
    instance foo_t -> struct foo changes)

Since you _do_ need the parens with a type, getting used to writing 
"sizeof foo" without them will then alert you and reader to the fact 
that something special is happening when you do see/use them.

If not enough of a reason to make "sizeof foo" the rule, please leave 
this up to personal preference.

Rene.

