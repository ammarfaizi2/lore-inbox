Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVHHNLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVHHNLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVHHNLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:11:55 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:38526 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750863AbVHHNLy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:11:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E8mrI2TfcnO49M9HmotqQkKckvJlUq2zJE5gWafupfVH96XuzKHV1M30m/VI7uBldtYtVyPVW4yWBzioE5iWlTI4v8uUjuP/SQZac199lqktzeyIZDTkHrbiezBIs1y9vApaSUq1xMoTYkXLL9x6dsEnzO3YH+Mmb6s/NM+LYPg=
Message-ID: <5edf7fc905080806117df1ab32@mail.gmail.com>
Date: Mon, 8 Aug 2005 18:41:53 +0530
From: Kedar Sovani <kedars@gmail.com>
To: rusty@rustcorp.com.au, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kedars@gmail.com
Subject: Unreliable Guide to Locking - Addition?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

          I was going through the splendidly written document,
"Unreliable Guide to Locking". I thought of something that should be
mentioned in the section "Using Atomic Operations For The Reference
Count" (link : http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/x352.html#EXAMPLES-REFCNT-ATOMIC)

I guess, probably the section should also mention that 
"
There is one race condition while using atomic_t, which is as follows :

* The refcount of the object is "1".

* Process A tries to perform atomic_dec_and_test(), gets "0" and hence
performs a kfree() on the object.

* Process B tries to perform atomic_inc() on the object.

* It may so happen that the atomic_inc() of Process B is called after
atomic_dec_and_test(), but before the kfree() call, which is a race
condition.

Usually, this race condition is avoided as:
    when the last atomic_dec_and_test() (the last == the one which
returns 0) is being called on the object, the object is usually not
accessible to others (list_del()) and hence the  simultaneous
atomic_inc() call never occurs.
"

Do you think this race condition should be included in the document?

Thanks,
Kedar.
