Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWJLQGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWJLQGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWJLQGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:06:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52140 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1422861AbWJLQGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:06:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MCEd69LfNc8AX6DdVi0aNEPLUT5jFVYtAXb566QXi6m0XZhyai1t6dXfg3EN5XD7vpE59pu6zP4qFVEOBIOL/FQUhK8Jg3xG8JrtN40QuiSJ/ZP2BFhpVQSGnZ6hA31eGeIJD740oglwygjh2vitVwOrh5UiEeESgdgf6siAMmo=
Message-ID: <653402b90610120905q8b7ae4by9166d0e6c0f95f43@mail.gmail.com>
Date: Thu, 12 Oct 2006 16:05:26 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <452E4D1A.9000409@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061012140422.93e7330c.maxextreme@gmail.com>
	 <452E4D1A.9000409@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me, also:

On 10/12/06, Paulo Marques <pmarques@grupopie.com> wrote:
>
> Also, what do these "nop"'s do? Isn't there a way to read the "busy"
> status from the controller and just write as fast as possible?
>

I found another bug that "changes" randomly the "startline" value. I
spent a _lot_ of time checking what would be the smallest way to have
the work done without any problem.

If you remove 1 of the 2 nops (after _address()), you will get some
flickering on one of the controllers, about 15 times per minute. If
you remove both, the "evil" controller do worse things.

Really, I have been trying a lot of ways to improve it and find the
explanation of that weird changes, and the best algorithm I found it
the one I have sent. Dirty, but it works safely. I also tried with
different timings and delays, but they didn't work. The only way I
found is to make the LCD do such "nop" operations.
