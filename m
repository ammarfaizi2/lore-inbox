Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUCLUfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUCLUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:33:25 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:38031 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S262454AbUCLU3u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:29:50 -0500
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF6FA69BBA.80AB3A29-ONC1256E55.0070477F-C1256E55.00708AF1@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 12 Mar 2004 21:29:16 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 12/03/2004 21:29:17
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Christoph,

> >  - Replace release function for device structures by kfree. Move struct
> >    device to the start of struct zfcp_port/zfcp_unit to make it work.
>
> That's ugly as hell.  Actually even more ugly.  It's not that ->release
> is such a performance critical path that you absolutely need to avoid one
> level of function calls.  So please put a simple wrapper back instead of
> the horrible casts and suddenly the silly placement restrictions are gone,
> too.

That it's ugly is true. But what's important is that it is required to get
module ref-counting right. The release function is called after the last
module_put has been done.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


