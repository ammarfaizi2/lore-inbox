Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVCUOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVCUOkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCUOkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:40:12 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:22690 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261798AbVCUOkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:40:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=C1WZV3snv7zJQUVR1cT+mKKQHYhNq3LI+NjxATSfKWbYwqe9F5+hkn8CalmE6mqXk6TL2CvPokuVzt8WlkgYraUtoGrflW7OQAhEXDsJrbC/lAZeCxfEzGGiA+yuIGEzX7FtVQ/7fL4DU2eb8kolyu8E6eZzXU155M0LU2mN/nk=
Message-ID: <d120d500050321064028e255fe@mail.gmail.com>
Date: Mon, 21 Mar 2005 09:40:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] driver model/scsi: synchronize pm calls with probe/remove
Cc: mochel@digitalimplant.org, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050321091846.GA25933@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050321091846.GA25933@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 18:18:46 +0900, Tejun Heo <htejun@gmail.com> wrote:
> Hello, Dmitry, Mochel and James.
> 
> I've been looking at sd code and found seemingly bogus 'if (!sdkp)'
> tests with /* this can happen */ comment.  I've digged changelog and
> found out that this was to prevent oops which occurs if some driver
> gets stuck inside ->probe and the machine goes down and calls back
> ->remove.  IMHO, we should avoid this problem by fixing driver ->probe
> or ->remove callbacks instead of detecting and bypassing
> half-initialized/destroyed devices in pm callbacks.
> 
> This patch read-locks a device's bus using device_pm_down_read_bus()
> before invoking any pm callback.

Hi Tejun,

There are talks about getting rid of bus's rwsem and replacing it with
a per-device semaphore to serialize probe, remove, suspend and resume.
This should resolve entire host of problems including this one, if I
unrerstand it correctly.

Please take a look here:
http://seclists.org/lists/linux-kernel/2005/Mar/5847.html

-- 
Dmitry
