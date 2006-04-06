Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWDFMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDFMWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDFMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:22:39 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:26555 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751055AbWDFMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:22:38 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Reply-To: 7eggert@gmx.de
Date: Thu, 06 Apr 2006 14:21:57 +0200
References: <5X7nH-7n6-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FRTVC-0000i5-PH@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Török Edwin <edwin@gurde.com> wrote:

> Fireflier aims at providing per application filtering. That is allowing to
> create rules like: allow apache to listen on port 80 (and only apache, nobody
> else).

I had a very simple idea for doing something like this:

Assign a special semantic to GID $n: Being in group $n allows you to listen
on port $n-$offset. $offset == -1 disables this feature (default).

E.g. You want apache to listen on 80 and 443: Set $offset to 60000 and put
apache into groups 60080 and 60443.

> I didn't include the patch inline, since it is quite long (1800+ lines ,
> ~100k). So I uploaded them here:
> http://edwintorok.googlepages.com/fireflier_kernel.html

(Text in parentheses written after completely reading the posting)

If I'd want it to work with iptables, I'd extend the socket struct to contain
the device:inode of the corresponding application (not changing it on exec)
and stat() the allowed applications on rule setups.
(I see you choose similar but more complicated approach, but:)

I'd deliberately allow access to these sockets if it's passed to other
applications since it's the intended behaviour. (BTW: Your approach isn't
going to be 100 % reliable, since it will allow other processes to illegaly
receive data if the socket is transfered after filtering, isn't it?)

Downside of both approaches:
 You'll have to guarantee stable dev:inode pairs. NFS? umount/mount?
 Workaround: suid helper setting/deleting the allowed-rule?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
