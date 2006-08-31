Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWHaPRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHaPRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWHaPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:17:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:6151 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751313AbWHaPRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fBFfUS6CjZNV8eo4M2zPz4GeQnoK6iEseoWPThpIS1e/bGWaDBgu/AG12SB/B7L7tw+UfCmUl7ci9dCt7VILJOlzRRg5bWGlBmpeTkRzC0yRnqyqE5+7YLpKA1mwDCJ26T5DUXnsN2XFwo09T19DOf4CIJpgDtbhBSWucjAPvKc=
Message-ID: <9a8748490608310817v7d722f88u167b5a84d0ff67e8@mail.gmail.com>
Date: Thu, 31 Aug 2006 17:17:20 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Unable to halt or reboot due to - unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
Cc: "Mark Evans" <evansmp@uhura.aston.ac.uk>,
       "Fred N. van Kempen" <waltje@uWalt.NL.Mugnet.ORG>,
       "Ross Biro" <ross.biro@gmail.com>, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, "Ben Greear" <greearb@candelatech.com>,
       netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a small problem with 2.6.18-rc5-git2.

I've got a vlan setup on eth0.20, eth0 does not have an IP.

When I attempt to reboot or halt the machine I get the following
message from the loop in net/core/dev.c::netdev_wait_allrefs() where
it waits for the ref-count to drop to zero.
Unfortunately the ref-count stays at 1 forever and the server never
gets any further.

  unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1

I googled a bit and found that people have had similar problems in the
past and could work around them by shutting down the vlan interface
before the 'lo' interface. I tried that and indeed, it works.

Any idea how we can get this fixed?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
