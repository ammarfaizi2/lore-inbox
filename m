Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVDOUKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVDOUKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVDOUKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:10:55 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:10594 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261950AbVDOUKt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sp3kHcPs2eWBKM0LSYOjWT7wPPVBN2iD8m7zVU3kUzg92kawHBMgV6tpLwqbm+fCSFmLsfu9O+GWDRFTFJ0iPi7QnTjA2By4xU6ghUXJeLuPEAV5W0sg2crHYNcIOikf/rForhocIs5z/m0+7xGmmqMi485jBinYr1h4cVOTI+Q=
Message-ID: <e1e1d5f40504151310467d16bd@mail.gmail.com>
Date: Fri, 15 Apr 2005 13:10:49 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Igor Shmukler <igor.shmukler@gmail.com>
Subject: Re: intercepting syscalls
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <6533c1c905041512594bb7abb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're welcome, Igor. I needed to intercept syscalls in a little
project that I were implementing, to keep track of filesystem changes,
and others. I use that way, but I know that it's a ugly hack that can
work only under x86. Overwrite syscalls can slow down the whole
system, and a improper wrapper can freeze the system and behave in a
unexpected way (imagine a non-freed memory allocation in a sys_read
wrapper...), and others. I never planned to use it at production.

If you're trying to do something to be public and widely used, I
believe that a better approach is to create a layer to be used in
syscalls operations, or something like that (stills ugly, but now it's
a "good-programming-practice" thing).

For example, from a kernel to other, the way that sys_write works
internally may change, and your code can mess with the whole thing.
Trap system calls are not a portable and clean way to reach your
goals. In fact, there's not a reliable way yet. (that I know)

I agree that a mechanism to wrap system calls can be very useful.

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
