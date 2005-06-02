Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFBN6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFBN6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFBN6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:58:32 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:45546
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261425AbVFBN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:58:25 -0400
Message-ID: <429F1079.5070701@ev-en.org>
Date: Thu, 02 Jun 2005 14:58:17 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, shemminger@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.12-rc5-mm2: "bic unavailable using TCP reno" messages
References: <20050601022824.33c8206e.akpm@osdl.org> <20050602121511.GE4992@stusta.de>
In-Reply-To: <20050602121511.GE4992@stusta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jun 01, 2005 at 02:28:24AM -0700, Andrew Morton wrote:
> 
>>...
>>Changes since 2.6.12-rc5-mm1:
>>...
>>+tcp-tcp_infra.patch
>>...
>> Steve Hemminger's TCP enhancements.
>>...
> 
> 
> I said "no" to CONFIG_TCP_CONG_BIC, and now my syslog is full of messages
>    kernel: bic unavailable using TCP reno
> 
> I have no problem with such a message being shown once - but once should 
> be enough.  

The best solution for this would be to check the available protocols at
setup time and not at connection creation time. This would also provide
a better feedback to the user, since he will either see that what he set
was taken, or it wasn't.

In the current mechanism you can set the protocol to 'foo' and it will
show back as 'foo'. You'll get complaints only once a connection is
attempted with this protocol.

It does mean some extra work in the sysctl stage, but it's better IMO to
do it there rather than at connection setup time.

Baruch
