Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753129AbWKFOam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbWKFOam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbWKFOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:30:42 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:47651 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753129AbWKFOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:30:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NyvM1glMKze9h46wn6kQxmu8lJoy9I+5BwMT9EZLPJLzgOe0o2ui+4HLQqm7kq7bbotSo+5PhBEWYLiLqwp+rDm5esk7DEd1QMg1BPOVXsB02cc+gQO0IczsB2B1fDVZhqEIoNUk1xAetNE7efIus13d3o1GHvhp0tUpJYJM7BA=
Message-ID: <454F470C.2050407@gmail.com>
Date: Mon, 06 Nov 2006 09:30:36 -0500
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: akpm@osdl.org, linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] airo.c: check returned values
References: <452C06A6.4030408@gmail.com> <454EEAEB.5030606@pobox.com>
In-Reply-To: <454EEAEB.5030606@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Florin Malita wrote:
>   
>> create_proc_entry() can fail and return NULL in setup_proc_entry(), the
>> result must be checked before dereferencing. (Coverity ID 1443)
>>
>> init_wifidev() & setup_proc_entry() can also fail in _init_airo_card().
>>
>> This adds the checks & cleanup code and removes some whitespace.
>>
>> Signed-off-by: Florin Malita <fmalita@gmail.com>
>>     
>
> NAK:  create_proc_entry() is complicated.  You are correct it can fail 
> -- but to add to the confusion, when CONFIG_PROC_FS is disabled, the 
> wrapper will also return NULL -- which is NOT a failure case.
>   

It is a failure condition for setup_proc_entry() but you're saying that
shouldn't cause a failure of _init_airo_card() as the driver would be
working fine even without procfs support, right?

Note that previously the no-procfs case was *really* broken (it would
explode right away in setup_proc_entry) and I'm not sure it can function
correctly without it now but I guess it's worth a try.

Which one would be preferred:

 a) make the setup_proc_entry() call in _init_airo_card() conditional on
CONFIG_PROC_FS
 b) simply ignore the result

---
fm
