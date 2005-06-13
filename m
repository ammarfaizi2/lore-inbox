Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVFMQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVFMQyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVFMQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:54:51 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:61084 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261872AbVFMQyu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:54:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFIp64R69Eabrh3i+deA5JKSIOvFcJCreW6R9jZR1jJI4bafWhMFWNgme/i0Uf8J6I5+cDVFR2ytLX1zRvsKCS3mnYktP8+vmcil0F4GSpvpK8vNMcLPS7fJV1lZ9hdXWyj/cgV9dKJZ9LQKywIKtCaByLglpHIuTi+e2SllzPg=
Message-ID: <29495f1d05061309543a88f9bb@mail.gmail.com>
Date: Mon, 13 Jun 2005 09:54:47 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: latency error (~2ms) with nanosleep
Cc: quade <quade@hsnr.de>, linux-kernel@vger.kernel.org
In-Reply-To: <42ADB8D1.9090503@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050613133047.GA11979@hsnr.de> <42ADB8D1.9090503@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, Chris Friesen <cfriesen@nortel.com> wrote:
> quade wrote:
> > Playing around with the (simple) measurement of latency-times
> > I noticed, that the systemcall "nanosleep" has always a minimal
> > latency from about ~2ms (haven't run it all night, so...). It
> > seems to be a systematical error.
> 
> Known issue.  The x86 interrupt usually has a period of slightly less
> than a ms.  It will therefore generally add nearly a whole ms to ensure
> that it does not ever wait for *less* than specified.

Exactly. And the sys_nanosleep() code adds one more if the parameter
has any positive value at all:

        expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
        current->state = TASK_INTERRUPTIBLE;
        expire = schedule_timeout(expire);

Thanks,
Nish
