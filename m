Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWCHGHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWCHGHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWCHGHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:07:05 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:19817 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750995AbWCHGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:07:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Fw: Re: oops in choose_configuration()
Date: Wed, 8 Mar 2006 01:06:59 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <200603072222.11504.dtor_core@ameritech.net> <20060308052302.GA29867@kroah.com>
In-Reply-To: <20060308052302.GA29867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603080107.00289.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 00:23, Greg KH wrote:
> > 
> > Hmm, what is the policy for attr->show()? With hotplug variables we
> > return -ENOMEM if there is not enough memory to store all data, but
> > what about attributes? Should we also return error (and which one,
> > -ENOMEM, -ENOBUFS?) or fill as much as we can and return up to
> > PAGE_SIZE?
> 
> Remember, sysfs files are supposed to be small, you are an "oddity" in
> that you have a much larger buffer that you can return due to the wierd
> aliases you have.
> 
> Truncating the buffer is probably good as we want userspace to get some
> information, right?
> 
> > With sysfs not kernel nor application can really recover
> > if attribute needs buffer larger than a page. Or just rely on BUG_ON
> > in fs/sysfs/file.c::fill_read_buffer()?
> 
> How about just making this a binary attribute, then you can handle an
> arbitrary size buffer and don't have to worry about the PAGE_SIZE stuff
> (but it makes it more code that you have to write to handle it all,
> there are tradeoffs...)
> 

I really don't believe that we ever going to cross 4096 boundary for any
single input attribute, but just to code defensively we need to decide
what to do if we ever encounter a crazy device. Just truncating to
PAGE_SIZE is easiest so that's what I am going to do.

-- 
Dmitry
