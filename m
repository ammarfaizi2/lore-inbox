Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWDDOjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDDOjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWDDOjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:39:42 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:41736 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932218AbWDDOjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:39:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g3vl637OSlP72+87WbEGbckooF5NhmWyGbhLM9HBCrX2nfDsHuqm7/Zq4VReFpBtI3FBIrI3isgWDEZFCiIvpDL7OrSic18/5B3OOhsJMASjirp5rSoGb+ne4iYnMZ8kYEJBq7frx3OeyRpGQt6p85SDCkDx47G8gn/uBowOaUQ=
Message-ID: <61291d840604040739m69642b26x4b24615112e37ce@mail.gmail.com>
Date: Tue, 4 Apr 2006 22:39:39 +0800
From: "pin xue" <pinxue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: a minor bug in via-rhine driver for linux
In-Reply-To: <61291d840604040738k1477cf72w7aadbc1e83d67bba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <61291d840604040738k1477cf72w7aadbc1e83d67bba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

kernel source version : 2.6.14

file : drivers/net/via-rhine.c

function : alloc_tbufs(), line 1021~1039

problem line : 1035
        rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];

fix: line 1035 should be
        if ( rp->quirks & rqRhineI )
            rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];

explaination:
line 718 : here we set rqRhineI flag only for old chips
line 922 : here we allocate buffers and alloc rp->tx_bufs only when
rqRhineI flag setted.
line 1035: here we initialize buffers, but set rp->tx_buf[] based on
tx_bufs anyway.
line 1273: here we use the buffers and refer rp->tx_buf[] only when
rqRhineI flag setted.
Currently, line 1035 does not cause any invalid memory accessing but
calculating and saving some invalid memory address.

comments:
I'm reading this driver and line 1035 confused me for a moment.



--
Best Regards!

Yang Wu

Mobile Phone: +86-013636674084
WorldWideWeb:  http://www.pinxue.net

--
Best Regards!

Yang Wu

Mobile Phone: +86-013636674084
WorldWideWeb: http://www.pinxue.net
