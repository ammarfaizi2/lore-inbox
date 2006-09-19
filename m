Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWISGYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWISGYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWISGYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:24:52 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44554 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964977AbWISGYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:24:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oxiizSLxQaHqoIgYKxVYvvgu/xIgkAx0l7eSPVBDTlnUbq+MJ+Sa79O03aUOiAvn0uddoPkRopUPJG8N3QWHiXdl39EdGXKq7pgLnNiArRfX1lMI1sjsM/FnTHZt/XcaWDsjZXuGqy/P7NHuIu3loYxbCSWTWGpb7dGghlBYZ1g=
Message-ID: <450F8D2E.6060700@gmail.com>
Date: Tue, 19 Sep 2006 15:24:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <450F88F0.307@garzik.org>
In-Reply-To: <450F88F0.307@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I don't really like this port_tbl approach.  I think it complicates 
> things too much.
> 
> Direct indexing should be fine.  For the non-linear case, just make sure 
> the non-existent ports are always dummy ports.  If the driver directly 
> references a port we know isn't there, that's just an AHCI bug to be 
> fixed...

I thought about that too, but it will end up with ata1-6 with dummy 3 
and 4 while the BIOS shows continuous 4 ports.  I wanted avoid this 
discrepancy as it could cause confusion to users.

The other option is adding pp->port_idx to record hw port index.  It 
does make the code a bit simpler.  What do you think about this?

Thanks.

-- 
tejun
