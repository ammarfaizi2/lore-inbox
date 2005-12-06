Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVLFMRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVLFMRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLFMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:17:09 -0500
Received: from souterrain.chygwyn.com ([194.39.143.233]:52097 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S964961AbVLFMQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:16:46 -0500
Date: Tue, 6 Dec 2005 12:28:57 +0000
From: Steven Whitehouse <steve@chygwyn.com>
To: kernel coder <lhrkernelcoder@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zero copy
Message-ID: <20051206122857.GA11688@souterrain.chygwyn.com>
References: <f69849430512060409k1798e377h442e42bbf17b0d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430512060409k1798e377h442e42bbf17b0d8a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Organization: ChyGwyn Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

See sock_no_sendpage() in linux/net/core/sock.c for when network
protocols don't support zerocopy and tcp_sendpage() in
linux/net/ipv4/tcp.c for an example where it is supported. The
NETIF_F_SG and TCP_ZC_CSUM_FLAGS test in the latter function
is probably what you are after?

Steve.

On Tue, Dec 06, 2005 at 04:09:30AM -0800, kernel coder wrote:
> hi,
> i'm trying to track the code flow of sendfile system call.Mine
> ethernet card doesn't have scatter gather and checksum calculation
> features.So stack should be making a copy of data.
> 
> Please tell me where in sendfile code flow,check for scatter gather
> and cecksum features is made so that stack can decide whether to copy
> data from user space or not.
> 
> lhrkernelcoder
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
