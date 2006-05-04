Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWEDRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWEDRyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWEDRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:54:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030242AbWEDRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:54:35 -0400
Subject: Re: limits / PIPE_BUF?
From: Arjan van de Ven <arjan@infradead.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605041044270.30003@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
	 <1146725882.3101.11.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0605040938310.19371@shell3.speakeasy.net>
	 <1146762968.3101.65.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0605041044270.30003@shell2.speakeasy.net>
Content-Type: text/plain
Date: Thu, 04 May 2006 19:54:33 +0200
Message-Id: <1146765273.3101.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 10:50 -0700, Vadim Lobanov wrote:
> On Thu, 4 May 2006, Arjan van de Ven wrote:
> 
> > On Thu, 2006-05-04 at 09:39 -0700, Vadim Lobanov wrote:
> > > How does the kernel
> > > code ensure that this value is honored, considering that PIPE_BUF is
> > > not
> > > referenced in any of the pipe code?
> >
> >
> > the kernel implementation guarantees one page basically, and on all
> > architectures that I know of that's at least 4096 bytes
> >
> 
> Alright, so sounds like this constant should remain inside the
> include/linux/limits.h file. What about #defining it to be equal to
> PAGE_SIZE, like ARM (include/linux-arm/limits.h, for example) does?

there is a certain elegance in providing the same value on all
architectures; it means apps don't suddenly break if you port it to 
a "lesser" one. Also there is a problem with PAGE_SIZE itself, that's a
config option on several architectures, so it'd have to be a define for
get_page_size() or something, at which point you change semantics since
apps can't do

char foo[PIPE_BUF];

anymore


