Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbVHPVHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVHPVHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVHPVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:07:04 -0400
Received: from matou.sibbald.ch ([194.158.240.20]:44871 "EHLO
	matou.sibbald.com") by vger.kernel.org with ESMTP id S932716AbVHPVGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:06:55 -0400
From: Kern Sibbald <kern@sibbald.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
Date: Tue, 16 Aug 2005 23:06:11 +0200
User-Agent: KMail/1.8.2
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200508161519.39719.kern@sibbald.com> <200508161638.15129.kern@sibbald.com> <20050816.113943.50223928.davem@davemloft.net>
In-Reply-To: <20050816.113943.50223928.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508162306.11873.kern@sibbald.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 20:39, David S. Miller wrote:
> From: Kern Sibbald <kern@sibbald.com>
> Date: Tue, 16 Aug 2005 16:38:14 +0200
>
> > Someone is setting nonblocking on my socket !
>
> Glad that's resolved...

Yes, my stupidity.  There was one more fcntl() in my source than I thought :-(

By the way, if a signal is delivered while blocked on a read, IMO, the OS 
should return EINTR.  If it doesn't, oh well, I'll live with it.

I wrote this code 5 years ago and was just now wondering why I bothered to 
test on EAGAIN. Your comment about a signal causing EAGAIN to be returned 
clarifies a lot.

