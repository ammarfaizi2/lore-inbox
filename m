Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWALFra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWALFra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWALFra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:47:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:18361 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964786AbWALFra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:47:30 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
cc: John Hesterberg <jh@sgi.com>, Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Wed, 11 Jan 2006 21:26:08 -0800."
             <1137043569.6673.156.camel@stark> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jan 2006 16:45:54 +1100
Message-ID: <14067.1137044754@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley (on Wed, 11 Jan 2006 21:26:08 -0800) wrote:
>On Thu, 2006-01-12 at 14:29 +1100, Keith Owens wrote:
>> An alternative patch that requires no locks and does not even require
>> RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2
>> 
>
>	Interesting. Might the 'inuse' flags suffer from bouncing due to false
>sharing?

It would, but that was the least of my worries.  Algorithm correctness
first, then tune it.  If necessary it could be converted to a per cpu
variable, as long as the timing between creating the per cpu variables
and invoking callbacks from hotplug cpu was correct.

