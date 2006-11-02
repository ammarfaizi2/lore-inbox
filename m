Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752266AbWKBTIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbWKBTIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbWKBTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:08:24 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:55850 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1752261AbWKBTIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:08:23 -0500
Message-ID: <454A4237.90106@cfl.rr.com>
Date: Thu, 02 Nov 2006 14:08:39 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
References: <20061102021547.GA1240@srv.junsun.net>  <454A1D82.7040709@cfl.rr.com> <1162486642.14530.64.camel@laptopd505.fenrus.org>
In-Reply-To: <1162486642.14530.64.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 19:08:27.0079 (UTC) FILETIME=[46B8D570:01C6FEB2]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14788.003
X-TM-AS-Result: No--10.395600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> that is a nice theory, but unfortunately there is just a lot of "PCI"
> hardware out there for which the designers decided to save a bit of
> copper and only wire up the lower X address lines (for various values of
> X)

Yea, but shouldn't PCI drivers be using another means than allocating 
from GFP_DMA?  Wasn't there some sort of bounce buffers call I can't 
quite remember the details of?  That performs any required translations 
to bus hardware addresses, and copies the buffer to a more appropriate 
location if required, based on the specific requirements of that device?

I know that most 32 bit PCI devices can't handle addresses above the 4 
GB mark on 64 bit machines, but those drivers should NOT be limiting DMA 
to the first 16 MB.  Especially since most machines don't have over 4 GB 
of ram anyhow, but quite often original buffers will be above 16 MB.

