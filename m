Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWFZRbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWFZRbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWFZRbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:31:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbWFZRbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:31:39 -0400
Date: Mon, 26 Jun 2006 10:31:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com, maneesh@in.ibm.com, Neela.Kolli@engenio.com,
       linux-scsi@vger.kernel.org, mike.miller@hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization
 issue fix
Message-Id: <20060626103130.de79fd9f.akpm@osdl.org>
In-Reply-To: <20060626171659.GG8985@in.ibm.com>
References: <20060623235553.2892f21a.akpm@osdl.org>
	<20060624111954.GA7313@in.ibm.com>
	<20060624043046.4e4985be.akpm@osdl.org>
	<20060624120836.GB7313@in.ibm.com>
	<m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
	<20060626021100.GA12824@in.ibm.com>
	<20060626133504.GA8985@in.ibm.com>
	<m11wtcvw5k.fsf@ebiederm.dsl.xmission.com>
	<20060626153239.GD8985@in.ibm.com>
	<m13bdrvrd4.fsf@ebiederm.dsl.xmission.com>
	<20060626171659.GG8985@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 13:16:59 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> So it is matter of making a choice in case the device does not have a
> software reset capability.
> 
> - Either try to make driver work through some hacks based on crashboot
>   option.
> 
> - Or mark the driver unusable in kdump scenarios.
> 
> Even if one decides to go for second option, at least "crashboot" or
> similar parameter will be required so that driver can choose whether
> to reset the device or not during initialization due to significant
> time penalty. 

yes, this does legitimise the `crashboot' option.

That being said, it's misnamed, I think.  It should be called
`reset_devices' or something.  Because that's what it does, and who
knows, there might be other reasons for wanting to reset devices.

See, it's more accurate.  We don't want drivers to be looking at some
global environmental thing and then independently working out what they
should be doing this time around.  We just want drivers to do what they're
told.

