Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWGRNbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWGRNbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWGRNbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:31:31 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:31143 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S932200AbWGRNba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:31:30 -0400
Message-ID: <44BCE15D.2090501@lucent.com>
Date: Tue, 18 Jul 2006 08:25:49 -0500
From: John Haller <jhaller@lucent.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: hadi@cyberus.ca, arjan@infradead.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, jeremy@goop.org, ak@suse.de,
       akpm@osdl.org, rusty@rustcorp.com.au, zach@vmware.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
References: <E1G2pJ3-0003LN-00@gondolin.me.apana.org.au>
In-Reply-To: <E1G2pJ3-0003LN-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> jamal <hadi@cyberus.ca> wrote:
>> I dont think the ifup/ifconfig provide operational status (i.e link
>> up/down) - or do they? If they can be made to invoke scripts in such
>> a case then we are set.
> 
> In fact, that's a very good reason why this shouldn't be in netfront.
> Indeed, it shouldn't be in the guest at all.  The reason is that the
> guest has no idea whether the physical carrier is present.
> 
> It's much better for the host to send the ARP packet on behalf of the
> guest since the host knows the carrier status and the guest's MAC
> address.
But sending ARPs is not the right thing if the guest is expecting
to use IPv6 networking, in which case unsolicited neighbor
advertisements are the right thing to do.  The driver just
doesn't seem to be the right place to do this, as it doesn't/
shouldn't need to know the difference between IPv4/IPv6.
