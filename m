Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284808AbRLEXII>; Wed, 5 Dec 2001 18:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284811AbRLEXH6>; Wed, 5 Dec 2001 18:07:58 -0500
Received: from mnh-1-14.mv.com ([207.22.10.46]:18440 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S284808AbRLEXHu>;
	Wed, 5 Dec 2001 18:07:50 -0500
Message-Id: <200112060025.TAA04538@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Tim Walberg <twalberg@mindspring.com>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removing an executable while it runs 
In-Reply-To: Your message of "Wed, 05 Dec 2001 14:54:42 CST."
             <20011205145442.A12034@mindspring.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 19:25:35 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

twalberg@mindspring.com said:
> mlockall() only locks those pages that are **currently** paged in, or
> optionally those that will be paged in in the future. Unless you have
> a way to make sure that all pages of the binary are actually in memory
> before you call mlockall(), this gains you nothing.

No, mlockall will page in the entire process before returning if you ask it to.

See this snippet in mlock_fixup:

		if (newflags & VM_LOCKED) {
			pages = -pages;
			make_pages_present(start, end);
		}

VM_LOCKED comes in through the mlockall system call.

				Jeff

