Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVJYSEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVJYSEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVJYSEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:04:14 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:43488 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932274AbVJYSEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:04:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFnN3G1wkkBzfdsk2CN/cDqxZYR5xS5s06PmCoA1KjdJdsrfPkEJdAbds/XOk7gjbsYd9dg8+YM5X7deJ4Mb4h8U1Mky/Xfl1JZohmGXSMXzeIqHbV4awsRmBH/9HSShtTuwiRiV3BbMCQTW7DYpMQsCWbf+96IuyUuLKqlsBqk=
Message-ID: <12c511ca0510251104s5b1fbb10u17b6146528793ad8@mail.gmail.com>
Date: Tue, 25 Oct 2005 11:04:12 -0700
From: Tony Luck <tony.luck@gmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: /proc/kcore size incorrect ? (OT)
Cc: Eric Piel <eric.piel@tremplin-utc.net>, jonathan@jonmasters.org,
       jonmasters@gmail.com, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <36402397-77C9-49A7-A143-2C672FC90934@able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051023235806.1a4df9ab@werewolf.able.es>
	 <35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com>
	 <20051024015710.29a02e63@werewolf.able.es>
	 <435E5720.6030105@tremplin-utc.net>
	 <36402397-77C9-49A7-A143-2C672FC90934@able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My concerns were about if the size of /proc/kcore should be what it is
> now, and why...

/proc/kcore is an ELF format file (try using objdump(1) to read
headers from it).

The data within the file may be sparse (especially on discontig
and NUMA systems).  So the size just represents the end of
the highest addressed memory section.  E.g. on my desktop:

$ ls -l /proc/kcore
-r--------  1 root root 4611686019496083456 Oct 25 09:52 /proc/kcore

-Tony
