Return-Path: <linux-kernel-owner+w=401wt.eu-S1030223AbXAKI1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbXAKI1N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbXAKI1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:27:13 -0500
Received: from secure.tummy.com ([66.35.36.132]:34690 "EHLO secure.tummy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030224AbXAKI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:27:12 -0500
Date: Thu, 11 Jan 2007 01:25:16 -0700
From: Sean Reifschneider <jafo@tummy.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() setting ERESTARTNOHAND (514).
Message-ID: <20070111082516.GU7121@tummy.com>
References: <20070110234238.GB10791@tummy.com> <20070110.162747.28789587.davem@davemloft.net> <20070111010429.GN7121@tummy.com> <20070110.171520.23015257.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110.171520.23015257.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-Hashcash: 1:26:070111:linux-kernel@vger.kernel.org::kVGU6rptVns8NnhY:000000000
	0000000000000000000000038cTJ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 05:15:20PM -0800, David Miller wrote:
>If you're only seeing it in strace, that's expected due to some

Nope, I haven't looked in strace at all.  It's definitely making it to
user-space.  The code in question is (abbreviated):

   if (select(0, (fd_set *)0, (fd_set *)0, (fd_set *)0, &t) != 0) {
      PyErr_SetFromErrno(PyExc_IOError);
      return -1;
      }

which causes the Python interpreter to raise an IOError exception, including
the value of errno, which is 514.

Thanks,
Sean
-- 
 This mountain is PURE SNOW!  Do you know what the street value of this
 mountain is!?!                -- Better Off Dead
Sean Reifschneider, Member of Technical Staff <jafo@tummy.com>
tummy.com, ltd. - Linux Consulting since 1995: Ask me about High Availability

