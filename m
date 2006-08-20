Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWHTRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWHTRdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWHTRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:33:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:40809 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751009AbWHTRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:33:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P8yedGpFaPdigWXcmh3PqXzW69Zf4ydwwe6kAB3RlbLjlD7al7cReTYW6XzByDfEEKN3Fq3aSmKFeb31yG96Kh21uwrB0atzEpE4D7sFOEVi9oE2VGcSzPSa2lmUo7Mxrw7IXYeWUSJ3qMEYtH0CyOTwSUv1Fovck0nMcuz1xyI=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: 800+ byte inlines in include/net/pkt_act.h
Date: Sun, 20 Aug 2006 19:33:10 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201933.10293.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

include/net/pkt_act.h plays a game of inlines
which are kind of "templatized", like this:

act_ipt.c:

/* ovewrride the defaults */
#define tcf_st          tcf_ipt
#define tcf_t_lock      ipt_lock
#define tcf_ht          tcf_ipt_ht
#define CONFIG_NET_ACT_INIT
#include <net/pkt_act.h>

This results in code duplication. For example,
tcf_generic_walker() is duplicated four times.
On i386 it is about 4*800 bytes in text section.
Other inlines are a bit smaller but still are substantial.
--
vda
