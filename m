Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424213AbWKIWpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424213AbWKIWpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424217AbWKIWph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:45:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54081 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424213AbWKIWpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:45:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gg2i8EcpWkhe9FB8k7awKQ7eGUj6qI+f7/reO10872/a5f33lD/ciwN08lV1MSZ1VmpZ78oFMXy3owq27i9rvxU6n8mLTqtSC9GSyBgrevqS5m8OABK3wsvePHOX1AZwL4ThIE4l0hV7qAibc+mHnHnAiZUR50bke/c8tMuHHlQ=
Message-ID: <4807377b0611091445s11575f5ej15c7bf7126bb5658@mail.gmail.com>
Date: Thu, 9 Nov 2006 14:45:34 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Jeffrey V. Merkey" <jmerkey@soleranetworks.com>
Subject: Re: e1000 driver 2.6.18 - how to waste processor cycles
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       "NetDEV list" <netdev@vger.kernel.org>
In-Reply-To: <4552EAFC.5060400@soleranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45524E3A.7080301@soleranetworks.com>
	 <4807377b0611081701i26ee7ce0k1f822dbbe52c2c8@mail.gmail.com>
	 <4552EAFC.5060400@soleranetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Jeffrey V. Merkey <jmerkey@soleranetworks.com> wrote:
> In the case I am referring to, the memory is already mapped with a
> previous call, which means it may be getting
> mapped twice.

I guess maybe I'm not keeping up with you.  This is what I see looking
in 2.6.18, i see e1000_clean_rx_irq:

check done bit
pci_unmap_single
copybreak and recycle
OR
hand buffer up stack

the only branch before the unmap is the napi break out, and in that
case we don't change any memory state, so alloc will not do anything.

As for alloc rx, we always map, because we always unmapped.

Did I miss something?  I would appreciate a more detailed explanation
of what you see going wrong.
