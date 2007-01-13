Return-Path: <linux-kernel-owner+w=401wt.eu-S1161191AbXAMCDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbXAMCDU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 21:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbXAMCDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 21:03:19 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:31921 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161191AbXAMCDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 21:03:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=XawnAjOoxCW6FJNPgPkAtMHb82lMZtyYCvOTN5byoIUYx948ACt0LaZH1Lz4xsUu+Gomy77WyKDMDe8v7pNi+h2clA6qQY2ZyCMdNKpPO2DyuMO/7TqRt2DUe+MxwtR5ylmN/Ru6BBTwDd5xpCkPjw0XJpQFIM5TAXsf6Gv+DSc=
Message-ID: <45A83DD2.5020000@gmail.com>
Date: Sat, 13 Jan 2007 11:02:58 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes for libata speed handling
References: <20070112135301.4cdba24f@localhost.localdomain>
In-Reply-To: <20070112135301.4cdba24f@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> I'm currently hacking on the speed handling code a bit
> 
> I'd like to do the following unless anyone has any objections
> 
> - Remove post_set_mode and make drivers wrap the guts of the existing
> set_mode() function. This allows a driver to wrap and see success/failure
> while removing a callback, and also to add pre-mode code. (ie you'd do
> 
> foo_set_mode() {
>     ata_default_set_mode()
>     my_fiddling();
> }
> 
> - Fix the ->set_mode method FIXMEs in the current tree [DONE]
> 
> - Add set_specific_mode, with a default behaviour that works for most
> controllers. Those using a private ->set_mode might need a private
> ->set_specific_mode, in some cases like it8212 simply to error the request
> 
> - Hook set_specific_mode to the ata command parser so that instead of
> erroring set_features commands we snoop them and force the mode change
> desired on the controller (if valid)
> 
> - Send the command to set the speed before setting the controller speed,
> so that we send them at the right rate.
> 
> Any comments ?

Wouldn't it be better to have ->determine_xfer_mask() and
->set_specific_mode() than having two somewhat overlapping callbacks?
Or is there some problem that can't be handled that way?

Thanks.

-- 
tejun
