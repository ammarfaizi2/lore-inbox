Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293688AbSCUOMf>; Thu, 21 Mar 2002 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312213AbSCUOM0>; Thu, 21 Mar 2002 09:12:26 -0500
Received: from boden.synopsys.com ([204.176.20.19]:26576 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S293688AbSCUOMQ>; Thu, 21 Mar 2002 09:12:16 -0500
Date: Thu, 21 Mar 2002 15:12:05 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Paul Larson <plars@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-pre3 - readv/writev should return EINVAL for count=0
Message-ID: <20020321151205.D1350@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Paul Larson <plars@austin.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1016650428.2202.98.camel@plars.austin.ibm.com> <20020321083408.C1350@riesen-pc.gr05.synopsys.com> <1016717331.2202.108.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

may be not. SunOS, HPUX, and AIX return EINVAL (unless it's their libc).
Maybe it is useful for compatibility with read/write.
And it's not really an error, after all, whereas EINVAL also means
overflow (sum of all iovec's longer than ssize_t) for readv/writev.
-alex

On Thu, Mar 21, 2002 at 07:28:50AM -0600, Paul Larson wrote:
> On Thu, 2002-03-21 at 01:34, Alex Riesen wrote:
> > I would disagree. According to the spec "The iovcnt argument is valid
> > if greater than 0 and less than or equal to {IOV_MAX}, as defined in
> > <limits.h>" (http://www.opengroup.org/onlinepubs/007904975/).
> > The behaviour you want to achieve is described as optional, besides
> > there is programs depending on the old behaviour (of my own at least :).
> > It's very handy to skip extra zero-parameter check...
> > -alex
> ^-This is the one I was referring to.  Is there any reason for it to not
> be in compliance with this?
> "The iovcnt argument is valid if greater than 0 and less than or equal to {IOV_MAX}, as defined in
>  <limits.h>" (http://www.opengroup.org/onlinepubs/007904975/)
> 
> Sorry, I just noticed that there was a previous thread here in which a
> patch was submitted by balbir_soni@yahoo.com.  I think the same person
> who started it might have been the same person that pointed out that one
> of our LTP testcases was passing when it shouldn't be and brought it to
> my attention.  It doesn't look like that thread got resolved though.
> 
> Paul Larson
