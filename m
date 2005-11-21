Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVKUWti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVKUWti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVKUWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:49:38 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:59599 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751213AbVKUWth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:49:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=ceNlCQafxDPBjl6+F0oYHcFD4lOiclwFd8WXgf6jtm05TJVJWkxOPoTaboUVEerPRi3r5uzp4BocqXyeyn/vxotiKYrV+N/yjACzrSW9PngquUtEkCHlrLb5RxB9ekStwJFebw+iu541+xN9cu+IQfJ9J7ZSaPbbSvsSE7CzPcg=;
Date: Tue, 22 Nov 2005 01:49:13 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Message-ID: <20051121224913.GA31287@ms2.inr.ac.ru>
References: <438220C3.4040602@nortel.com> <E1EeIcx-0006i3-00@gondolin.me.apana.org.au> <20051121213549.GA28187@ms2.inr.ac.ru> <4382406D.1040508@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4382406D.1040508@nortel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> TIPC wants the user to fill in the pid to use in the nlmsghdr portion of 
> a particular message.

It is wrong. netlink_pid used not to be associated with process pids.
Kernel used pid just as a seed to calculate a random value to bind,
when user did not bind explicitly. It is equal to current->pid occasionally.
F.e. libnetlink from iproute autobinds and gets netlink_pid with
getsockname().

When user binds the socket himself, he was free to bind to any value,
including pid and tgid.

Actually, I remember one discussion. Herbert, wait a minute...
That's it: February 2005, Subject: [PATCH] Add audit uid to netlink credentials
We decided (or not?) that binding to anything but tgid and pid
must be prohibited by security reasons. Apaprently, the finding was lost.

Alexey
