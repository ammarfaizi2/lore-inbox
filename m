Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTK0VOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 16:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTK0VOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 16:14:08 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:59640 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261262AbTK0VOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 16:14:05 -0500
Date: Thu, 27 Nov 2003 16:14:00 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-ID: <20031127211400.GD1560@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031127194602.A25015@flint.arm.linux.org.uk> <20031128.045413.133305490.yoshfuji@linux-ipv6.org> <20031127200041.B25015@flint.arm.linux.org.uk> <20031128.054724.116712136.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128.054724.116712136.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 05:47:24AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <20031127200041.B25015@flint.arm.linux.org.uk> (at Thu, 27 Nov 2003 20:00:41 +0000), Russell King <rmk+lkml@arm.linux.org.uk> says:
> 
> > The thing that worries me is that an incorrect strlcpy() conversion
> > gives the impression that someone has thought about buffer underruns
> > as well as overruns, and, unless someone /has/ actually thought about
> > it, there could well still be a security problem lurking there.
> 
> Hmm, what do you actually mean by "buffer underruns?"
> 
> (If I'm correct) do you suggest that we should zero-out rest of 
> destination buffer?
> 
> if so, we may want to have a function, say strlcpy0(), like this:
> 
> size_t strlcpy0(char *dst, const char *src, size_t maxlen)
> {
>   size_t len = strlcpy(dst, src, maxlen);
>   if (maxlen && len < maxlen - 1)
>     memset(dst + len + 1, 0, maxlen - len - 1);
>   return len;
> }
> 

size_t strlcpy0(char *dst, const char *src, size_t maxlen)
{
  memset(dst, 0, maxlen);
  size_t len = strlcpy(dst, src, maxlen);
  return len;
}

-- 
Murray J. Root

