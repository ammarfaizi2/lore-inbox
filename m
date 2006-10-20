Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992569AbWJTHhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992569AbWJTHhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992571AbWJTHhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:37:53 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9437 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S2992569AbWJTHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:37:52 -0400
Message-ID: <45387CCD.9030005@freenet.de>
Date: Fri, 20 Oct 2006 09:37:49 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	<45367210.4040507@googlemail.com>	<200610182118.31371.rjw@sisk.pl>	<4536818E.3060505@fr.ibm.com>	<453683A6.9090106@yahoo.com.au>	<45368E0A.1030503@fr.ibm.com> <20061018152346.0486b6bc.akpm@osdl.org> <4537A263.4090601@freenet.de> <4537BF8A.9040004@yahoo.com.au>
In-Reply-To: <4537BF8A.9040004@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
 > I don't believe filemap_xip holds the page lock, so you don't need to do
 > the atomic copy, and you don't need to do the fault_in_pages_readable.
No, we don't hold the page lock. Xip pages are property of the block 
device driver, are not in the page lru, and by calling get_xip_page we 
retrieved a reference to that page which remains valid until the file 
system is unmounted / the block device is closed.
