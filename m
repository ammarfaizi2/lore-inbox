Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUIPLvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUIPLvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIPLrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:47:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:37559 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S267973AbUIPLka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:40:30 -0400
Subject: Re: Being more careful about iospace accesses..
From: David Woodhouse <dwmw2@infradead.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916001001.GN23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
	 <52zn3rupw8.fsf@topspin.com>
	 <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
	 <20040916001001.GN23987@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1095334825.9144.2305.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 16 Sep 2004 12:40:25 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 01:10 +0100,
viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Sep 15, 2004 at 04:26:12PM -0700, Linus Torvalds wrote:
>  
> >    other bitwise type. You'd get a warnign about incompatible types. Makes 
> >    sense, no?
> >  - you can only do operations that are safe within that byte order. For 
> >    example, it is safe to do a bitwise "&" on two __le16 values. Clearly 
> >    the result is meaningful.
> 
> BTW, so far the most frequent class of endianness bugs had been along the
> lines of
> 	foo->le16_field = cpu_to_le32(12);
> and vice versa.  On big-endian it's a guaranteed FUBAR - think carefully about
> the value that will end up there.

Is that really more frequent than just 'foo->le16_field = 12' ? 
I'm surprised. 

Certainly, it was the frequency of pure assignment without _any_ attempt
at byte-swapping which caused me to introduce the 'jint32_t' et al
structures in jffs2, which even gcc then bitches about if you use them
wrongly.

I suppose I can ditch those now -- I always intended to after a while
anyway.

-- 
dwmw2


