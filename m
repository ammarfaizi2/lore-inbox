Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUA0OAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUA0OAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:00:19 -0500
Received: from relay.inway.cz ([212.24.128.3]:65178 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S263625AbUA0OAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:00:11 -0500
Message-ID: <40166EA9.9040806@scssoft.com>
Date: Tue, 27 Jan 2004 14:59:05 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
References: <Pine.LNX.4.44.0401261625210.3324-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0401261625210.3324-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:

>Petr, sorry for the suspense.  Here's a patch against 2.6.2-rc2 that fixes 
>a race in the Tx path of e1000 that you may be exposing with TSO on.  The 
>race is:
>
>Tx queue		Tx clean (interrupt context)
>
>...
>if(h/w Q full)         | clean h/w Q
>        ...        <---| if(s/w Q stopped) 
>        stop s/w Q     |       wake s/w Q
>
>
>So let's try this patch with TSO back on.
>  
>
Scott,

thanks for the patch. Again, 3/4 of working day with moderate server 
load resulted in no
WATCHDOG barking with the patched kernel and tso's turned on. I dare say 
that this is it! :-)
(Little more testing here won't harm though)

If nothing, the stability of the e1000 has vastly improved

Thanks a lot!

Regards,
Petr

