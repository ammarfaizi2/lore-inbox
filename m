Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUHOUDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUHOUDc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUHOUDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:03:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:37326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266858AbUHOUDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:03:30 -0400
Date: Sun, 15 Aug 2004 13:01:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Santiago Leon <santil@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] ibmveth bug fixes 4/4
Message-Id: <20040815130145.794615d8.akpm@osdl.org>
In-Reply-To: <41190E97.2050705@us.ibm.com>
References: <41190E97.2050705@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Leon <santil@us.ibm.com> wrote:
>
> his patch adds a memory barrier to ensure synchronization with the 
>  hypervisor (and avoid a panic when the hypervisor is halfway through 
>  writing to the descriptor). It also removes an unnecessary check that is 
>  flawed anyway because the value can change between the atomic_inc() and 
>  the assert. Please apply.
> 
> ...
>  @@ -733,6 +732,8 @@
>   
>   		if(ibmveth_rxq_pending_buffer(adapter)) {
>   			struct sk_buff *skb;
>  +
>  +			rmb();

Please always add a comment when adding such a barrier - it is otherwise
quite impossible for the reader to work out what it is doing in there.

Also, please in future avoid giving your patches subjects such as "ibmveth
bug fixes 4/4".  Remember that the Subject: in your email will be carried
through into kernel bitkeeper and it should be meaningful.

I relabelled these four patches as

	ibmveth: module tag fixes
	ibmveth: race fixes
	ibmveth: hypervisor return value fix
	ibmveth: add memory barrier for hypervisor synchronisation

Thanks.
