Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758352AbWK0QPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758352AbWK0QPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbWK0QPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:15:48 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:18491 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1758352AbWK0QPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:15:47 -0500
Message-ID: <456B0F53.90209@cfl.rr.com>
Date: Mon, 27 Nov 2006 11:16:19 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: G.Ohrner@post.rwth-aachen.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr> <ek54hf$icj$2@sea.gmane.org>
In-Reply-To: <ek54hf$icj$2@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 16:15:52.0722 (UTC) FILETIME=[4F5F1720:01C7123F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14838.003
X-TM-AS-Result: No--12.662200-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunter Ohrner wrote:
> IMHO something really fishy's going on there. If I explicitely write data
> into the pool, it shouldd not stay at "zero", from wwhat I understood about
> how /dev/*random work.
> 

<snip>

> I'm mainly wondering why writing stuff to /dev/*random does not change the
> entropy from zero to at least any low non-zero value...
> 

I ran into this the other day myself and when I investigated the kernel 
code, I found that writes to /dev/random do accept the data into the 
entropy pool, but do NOT update the entropy estimate.  In order to do 
that, you have to use a root only ioctl to add the data and update the 
estimate.  I am not sure why this is, or if there is a tool already 
written somewhere to use this ioctl, maybe someone else can comment?


