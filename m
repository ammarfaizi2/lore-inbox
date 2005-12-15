Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbVLOLqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbVLOLqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbVLOLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:46:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39057 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422691AbVLOLqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:46:20 -0500
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-scsi@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <43A1524E.70200@de.ibm.com>
References: <43A044E6.7060403@de.ibm.com>
	 <20051214165900.GA26580@infradead.org>  <43A0E8E7.1060706@de.ibm.com>
	 <1134632229.16486.3.camel@laptopd505.fenrus.org>
	 <43A1524E.70200@de.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 12:46:14 +0100
Message-Id: <1134647174.16486.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 12:23 +0100, Martin Peschke wrote:

> Given the idea of struct statistic, the lower layer driver could use a 
> given pointer to an upper layer's struct statistic in order to call 
> statistic_inc(stat, x).
> 
> The lower layer driver could call an upper layer driver's function to 
> have the upper layer update a statistic. 

Why? it's an open source world, what you suggest is more something for a
"must hide behind interfaces" closed world ;)

if done right, the LLDD gets access to the transport class information,
including the array of stats, so the LLDD can update those just fine.
Just the API should be clear about who owns updating which field; a
comment will suffice for that ;)


> The lower layer driver could temporarily store some measurement data in 
> the data structure passed between those two; the upper layer driver 
> picks it up later and calls whatever statistic library routine is 
> appropriate. Requires additional bytes and one store/retrieve operation 
> more than the struct statistic idea.

way way too complex for no reason.

Remember the scsi layer is a layered concept, but also upside down: even
though the transport class layers on top of the LLDD, it's the LLDD that
drives that class, not the other way around. The same could be done with
selected statistics; have the transport layer do the exporting to sysfs
and all that stuff, but have the LLDD keep track of them. (of course
only for those that are relevant in this sense; if the transport class
is the natural place to update, then it should be done there)


