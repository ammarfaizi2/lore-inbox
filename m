Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTLDGv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTLDGv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:51:58 -0500
Received: from fmr06.intel.com ([134.134.136.7]:8174 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262775AbTLDGv5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:51:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Extremely slow network with e1000 & ip_conntrack
Date: Wed, 3 Dec 2003 22:51:44 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD1F@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Extremely slow network with e1000 & ip_conntrack
Thread-Index: AcO4paDbQopOJrwLSfm5lMgBKgt5pABjVgug
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Harald Welte" <laforge@netfilter.org>,
       "Stephen Lee" <mukansai@emailplus.org>
Cc: <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2003 06:51:45.0065 (UTC) FILETIME=[14BEC190:01C3BA33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I compiled lots of kernels :-( and narrowed it down to between 
> > > 2.5.26 and 2.5.46.
> > > 
> > > Kernel version	Chip		Problem?
> > > 2.4.22		82540EM		N
> > > 2.5.26		82540EM		N
> > > 2.5.46		82540EM		Y
> > > 2.6.0-test10		82540EM		Y
> > > 2.6.0-test11		82540EM		Y
> > > 2.6.0-test11		82547EI		N
> > > 2.4.22nptlsmp		82547EI		N

In e1000, check this out:

  #ifdef NETIF_F_TSO
          if((adapter->hw.mac_type >= e1000_82544) &&
             (adapter->hw.mac_type != e1000_82547))
                  netdev->features |= NETIF_F_TSO;
  #endif

Try turning off TSO by disabling this code or by using "ethtool -K tso
off" (need version 1.8).

-scott
