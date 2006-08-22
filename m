Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWHVPJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWHVPJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHVPJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:09:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:3956 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932305AbWHVPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:09:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=XI+OLsvUVdQEMsD/illKLmSGSW14V68r/ssy3NUlbyElF59vSTA9wYCWZ+mYSXY8m0jcjMRCOe0v3Xzw14ZhpOI1CNBa5I0O7Gei5Qazy3ZIpwSwzmzhhabHOn5yV5R/qNBXBXfaH1tZuQkalvJ4EukzQo4hwgMnCMi5Funhf1A=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] make mdelay, udelay and ssleep calls smaller
Date: Tue, 22 Aug 2006 17:08:10 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608221708.10115.vda.linux@googlemail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, magic in include/linux/delay.h
inlines mdelay and ssleep, and various arches
do the same to udelay.

This is pointless. We are going to perform a delay of 1000+
CPU cycles anyway, no need to optimize away a few cycles.

This patchset converts calls to these functions
into true functuon calls, with no additional
math done or hidden arguments pushed to stack
at the callsite.

Tested on i386, (almost) allyesconfig kernel:

# size linux-2.6.17.9.org/vmlinux linux-2.6.17.9.delay/vmlinux
    text    data     bss      dec     hex filename
25342204 5921954 1937036 33201194 1fa9c2a linux-2.6.17.9.org/vmlinux
25335905 5921982 1937036 33194923 1fa83ab linux-2.6.17.9.delay/vmlinux

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
--
vda
