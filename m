Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWBTORx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWBTORx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWBTORw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:17:52 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:56405 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964921AbWBTORv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:17:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=izTXCTMyMlSMbqqe8zeFpG0YLW4F2hW6TDUfn1N1rbQSYAMIM9BdJhqPaj7kP2uGV3uJW0kWYpO8D0Uz+bt5lu/ZR2TWohindbM25XJ4BqIaL3ujlJwzebGHWNylTCIXol/xgV2rpHvi0GaQEjFz+izES/5SMMAw7zMj2g9X0LQ=
Message-ID: <43F9CF85.1020500@gmail.com>
Date: Mon, 20 Feb 2006 23:17:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jfeise@feise.com
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Kernel oops: 2.6.16-rc3-mm1 dvd mount
References: <43F4A5FE.3080601@feise.com> <43F96743.9050103@gmail.com>
In-Reply-To: <43F96743.9050103@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> This oops happened because get_request() was invoked with NULL @q.  It 
> seems like SCSI midlayer refcounting mixup.  I'll dig deeper and report 
> again as soon as I can find something concrete.

Hello, all & James.

I've bisected the patch series and the winner is #221 
git-scsi-misc.patch which seems to contain eight commits. I think SCSI 
people can hunt this down from now on. The bug happens whenever sr block 
device is accessed - mount, cat, whatever, and now it seems like some 
kind of data overrun.

Hope it helped.

-- 
tejun
